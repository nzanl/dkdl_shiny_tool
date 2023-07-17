library(data.table)
library(partykit)
library(caret)

generate_test_input <- function(){
  input <- list()
  input$Q2 <- 1
  input$Q4 <- 2
  input$Q5 <- 2
  input$Q6 <- 2
  input$Q7 <- 2
  input$Q8 <- 2
  input$Q9 <- 2
  input$Q10 <- 2
  input$Q11 <- 2
  input$Q12 <- 2
  return(input)
}

determine_cp <- function(input){
  # check initiele vragen
  Q1 <- ifelse(is.null(input$Q1), "0", input$Q1)
  Q2 <- ifelse(is.null(input$Q2), "0", input$Q2)
  Q3 <- ifelse(is.null(input$Q3), "0", input$Q3)
  
  if(!(Q1 == "1" & Q2 == "1" & Q3 == "1")){
    if(input$Q1 == "2") return("Medische kindzorg thuis") # voorliggend
    else if(input$Q2 == "2") return("Palliatief-terminale zorgvraag < 3 maanden") # daarna PTZ
    else if(input$Q3 == "2") return("Tijdelijk DKDL profiel") # daarna DKDL uitzonderingen
    else if(input$Q3 == "3") return("Geen DKDL beschikbaar")
    else {return("Nog niet alle initiele vragen beantwoord")}
  }
  # we zijn er nog: dus door naar de DKDL
  if(!(!is.null(input$Q4) & !is.null(input$Q5) & !is.null(input$Q6) & 
     !is.null(input$Q7) & !is.null(input$Q8) &
     !is.null(input$Q9) & !is.null(input$Q10) & !is.null(input$Q11) & !is.null(input$Q12))) return("Nog niet alle DKDL vragen beantwoord")

  # construct a df data.frame with required colnames for data processing and model prediction
  df <- data.frame(VR_technisch_infuusbehandeling = 0, # is prestatie hoogcomplexe TT geworden
                   VR_psychisch = factor(as.integer(input$Q4), levels = 1:3),
                   VR_geheugen = factor(as.integer(input$Q5), levels = 1:3),
                   VR_sociaal = factor(as.integer(input$Q6), levels = 1:3),
                   VR_mantelzorg = factor(as.integer(input$Q7), levels = 1:2),
                   VR_verloop = factor(as.integer(input$Q8), levels = 1:3),
                   VR_verloop.4 = as.integer(input$Q2) - 1,
                   VR_continentie = factor(as.integer(input$Q9), levels = 1:4),
                   VR_wassen = factor(as.integer(input$Q10), levels = 1:3),
                   VR_medicatie = factor(as.integer(input$Q11), levels = 1:3),
                   VR_technisch_complexewonden = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_complexewonden" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_darmspoeling = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_darmspoeling" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_eenmaligeofverblijfskatheter = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_eenmaligeofverblijfskatheter" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_darmstoma = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_darmstoma" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_injecties = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_injecties" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_overigeblaasennierkatheterisatie = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_overigeblaasennierkatheterisatie" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_sonde = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_sonde" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   VR_technisch_zwachtelen = ifelse(is.null(input$Q13), 0, ifelse("VR_technisch_zwachtelen" %in% input$Q13 & input$Q12 == TRUE, 1, 0)),
                   y = 1,
                   cm_VragenlijstID = 1)
  print(df)
  # then apply DK DL OB transform
  df_tf <- dkdl_transformations(df)
  print(df_tf)
  # then create party object
  treemodel <- combine_data_with_tree(df_tf)
  # then predict node
  df_tf$cluster_id <- predict(treemodel, type = "node")
  # then add cluster name
  source("dkdl_model/add_cluster_labels.R", local = TRUE)
  df_tf <- na.omit(add_cluster_labels(df_tf, modelNaam = "Draagkracht/draaglast model variant3",
                              config_dir = "dkdl_model/"))
  cluster_name <- paste0(df_tf$hoofd_categorie, ", ",  df_tf$subgroep)
  return(cluster_name)
}

dkdl_transformations <- function(df_tmp){
  
  # one hot encoding using caret
  df <- caret::dummyVars(~ ., data = df_tmp)
  df <- data.table(predict(df, newdata = df_tmp))
  
  df <- as.data.table(df)

  # DK
  df <- df[, DK := 7 - sum(VR_psychisch.1*0, VR_psychisch.2*2, VR_psychisch.3*2,
                           VR_sociaal.1*0, VR_sociaal.2*1, VR_sociaal.3*3,
                           VR_geheugen.1*0, VR_geheugen.2*2, VR_geheugen.3*2), .(cm_VragenlijstID)]
  
  # DL
  df <- df[VR_verloop.4 != 1, DL := sum(VR_verloop.1*0, VR_verloop.2*1, VR_verloop.3*2, 
                                        VR_mantelzorg.1*0, VR_mantelzorg.2*1), .(cm_VragenlijstID)]
  
  df <- df[VR_verloop.4 == 1, DL := -1]
  
  # OB
  df <- df[, OB := sum(VR_continentie.1*0,VR_continentie.2 *1, VR_continentie.3*1 , VR_continentie.4*2,
                       VR_wassen.1*0 , VR_wassen.2*2, VR_wassen.3*4 ,  
                       VR_medicatie.1*0, VR_medicatie.2 *2, VR_medicatie.3*2 , 
                       VR_technisch_complexewonden, VR_technisch_darmspoeling*2,
                       VR_technisch_darmstoma, VR_technisch_eenmaligeofverblijfskatheter,
                       VR_technisch_injecties, VR_technisch_overigeblaasennierkatheterisatie,
                       VR_technisch_sonde*2,
                       VR_technisch_zwachtelen), .(cm_VragenlijstID)]
  
  
  
  df <- as.data.table(df)
  return(df)
}

combine_data_with_tree <- function(df_orig){
  
  # select ingredients for tree model
  col_names <- c("VR_verloop.4", 
                 "VR_technisch_infuusbehandeling",
                 "DK",
                 "DL",
                 "OB",
                 "y")
  
  df <- df_orig %>% select(all_of(col_names))

  # Lookup splits: NB this need a dataset `df` present in the background
  source("dkdl_model/dkdl_splits.R", local = TRUE)
  
  # generate partykit node structure with references to specific columns in df
  source("dkdl_model/dkdl_model.R", local = TRUE)

    treemodel <- partykit::party(node = pn, 
                               data = df, 
                               fitted = data.frame("(fitted)" = fitted_node(pn, data = df),
                                         "(response)" = df$y,
                                         check.names = FALSE), # needed for the funky names
                               terms = terms(y ~ ., data = df) # model formula
  )
  # Function fitted_node() performs all splits recursively
  # and returns the identifier id of the terminal node each observation in data[obs,] belongs to
  treemodel <- as.constparty(treemodel)
  return(treemodel)
}
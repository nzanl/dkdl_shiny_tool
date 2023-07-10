add_cluster_labels <- function(df, modelNaam, config_dir = "../config/"){
  df <- as.data.table(df)
  df <- df %>%
    select(!any_of(c("cluster_sort_nr", "hoofd_categorie", "subgroep", "categorie_soort")))
  
  kennis_clusters <- as.data.table(read.csv2(paste0(config_dir, "cluster_labels.csv")))
  kennis_clusters <- kennis_clusters %>% 
    filter(model_naam == modelNaam) %>%
    select(!c(model_nr, model_naam, row_id))
  
  setkey(kennis_clusters, cluster_id)
  setkey(df, cluster_id)
  
  df <- df[kennis_clusters]
  return(df)
}

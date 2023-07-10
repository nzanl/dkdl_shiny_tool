# simulate fake DKDL data

set.seed(123)

sample_size <- 20000

df <- tibble(VR_technisch_infuusbehandeling = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_geheugen = sample(x = (1:3), size = sample_size, replace = TRUE, prob = c(0.7, 0.2, 0.1))) %>%
  mutate(VR_psychisch = sample(x = (1:3), size = sample_size, replace = TRUE, prob = c(0.8, 0.15, 0.05))) %>%
  mutate(VR_sociaal = sample(x = (1:3), size = sample_size, replace = TRUE, prob = c(0.8, 0.15, 0.05))) %>%
  mutate(VR_verloop = sample(x = (1:4), size = sample_size, replace = TRUE, prob = c(0.4, 0.3, 0.2, 0.1))) %>%
  mutate(VR_mantelzorg = sample(x = (1:2), size = sample_size, replace = TRUE, prob = c(0.8, 0.2))) %>%
  mutate(VR_medicatie = sample(x = (1:5), size = sample_size, replace = TRUE, prob = c(0.2, 0.2, 0.2, 0.2, 0.2))) %>%
  mutate(VR_wassen = sample(x = (1:4), size = sample_size, replace = TRUE, prob = c(0.5, 0.3, 0.1, 0.1))) %>%
  mutate(VR_continentie = sample(x = (1:4), size = sample_size, replace = TRUE, prob = c(0.6, 0.15, 0.15, 0.05))) %>%
  mutate(VR_technisch_complexewonden = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_darmspoeling = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_eenmaligeofverblijfskatheter = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_darmstoma = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_injecties = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_overigeblaasennierkatheterisatie = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_sonde = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(VR_technisch_zwachtelen = rbinom(n = sample_size, size = 1, prob = 0.05)) %>%
  mutate(y = rpois(n = sample_size, lambda = 20)/10) %>%
  mutate(cm_VragenlijstID = 1:sample_size)
  
one_hot_vars <- vars(VR_geheugen, VR_psychisch, VR_sociaal, 
                     VR_verloop, VR_mantelzorg, 
                     VR_medicatie, VR_wassen, VR_continentie)

df_tmp <- df %>% 
  mutate_at(one_hot_vars, factor)

# one hot encoding
df <- dummyVars(~ ., data = droplevels(df_tmp))
df <- data.table(predict(df, newdata = df_tmp))

df <- as.data.table(df)

#######################################
# DK/DL/OB
df <- df[, DK := 7 - sum(VR_psychisch.1*0, VR_psychisch.2*2, VR_psychisch.3*2,
                               VR_sociaal.1*0, VR_sociaal.2*1, VR_sociaal.3*3,
                               VR_geheugen.1*0, VR_geheugen.2*2, VR_geheugen.3*2), .(cm_VragenlijstID)]

# 
df <- df[VR_verloop.4 != 1, DL := sum(VR_verloop.1*0, VR_verloop.2*1, VR_verloop.3*2, 
                                          VR_mantelzorg.1*0, VR_mantelzorg.2*1), .(cm_VragenlijstID)]

df <- df[VR_verloop.4 == 1, DL := -1]

# gezond mag geen punten geven
df <- df[, OB := sum(VR_continentie.1*0,VR_continentie.2 *1, VR_continentie.3*1 , VR_continentie.4*2,
                           VR_wassen.1*0 ,VR_wassen.2 *0, VR_wassen.3*2, VR_wassen.4*4 ,  
                           VR_medicatie.1*0, VR_medicatie.2*0, VR_medicatie.3*0 , VR_medicatie.4 *2, VR_medicatie.5*2 , 
                           VR_technisch_complexewonden, VR_technisch_darmspoeling*2,
                           VR_technisch_darmstoma, VR_technisch_eenmaligeofverblijfskatheter,
                           VR_technisch_injecties, VR_technisch_overigeblaasennierkatheterisatie,
                           VR_technisch_sonde*2,
                           VR_technisch_zwachtelen), .(cm_VragenlijstID)]



df <- as.data.table(df)


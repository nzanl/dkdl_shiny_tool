# caret wrapper

partykit_dkdl <- list(label = "partykit_dkdl",
                     library = c("partykit"),
                     loop = NULL,
                     type = c("Regression"),
                     parameters = data.frame(parameter = "parameter",
                                             class = "character",
                                             label = "parameter"),
                     grid = function(x, y, len = NULL, search = "grid") data.frame(parameter = "none"),
                     fit = function(x, y, wts, param, lev, last, classProbs, ...) {
                       
                      # construct dataset
                       df <- data.frame(y, x)

                       source("dkdl_model.R", local = TRUE)

                       fitted_df <- data.frame("(fitted)" = partykit::fitted_node(node = pn, data = df),
                                            "(response)" =  df$y,
                                            check.names = FALSE) # needed for the funky names

                       
                       my_tree <- partykit::party(node = pn, 
                                                     data = df, 
                                                     fitted = fitted_df,
                                                     terms = terms(my_formula, data = df)
                                    ) 
                       out <- partykit::as.constparty(my_tree)
                       out
                       
                     },
                     predict = function(modelFit, newdata, submodels = NULL) {
                       newdata <- as.data.frame(newdata)
                       partykit::predict.party(modelFit, newdata, FUN = weighted.mean)
                     },
                     prob = NULL,
                     tags = NULL,
                     notes = paste("This is a fixed partykit tree model",
                                   "it therefore has no tuning parameters"),
                     sort = function(x) x)




# DKDL model v2.0

# node structure

pn <- partynode(id = 1L, split = sp_palliatief_verloop,
                kids = list(
                  partynode(id = 2L, split = sp_technisch_infuus,
                            kids = list(
                              partynode(id = 4L, split = sp_DK,
                                        kids = list(
                                          partynode(id = 6L, split = sp_DL,
                                                    kids = list(partynode(id = 8L, split = sp_OB3,
                                                                          kids = list(
                                                                            partynode(id = 12L, split = sp_OB2,
                                                                                      kids = list(
                                                                                        partynode(id = 16L),
                                                                                        partynode(id = 17L)
                                                                                      )),
                                                                            partynode(id = 18L)
                                                                          )),
                                                                partynode(id = 9L, split = sp_OB3,
                                                                          kids = list(
                                                                            partynode(id = 13L, split = sp_OB2,
                                                                                      kids = list(
                                                                                        partynode(id = 19L),
                                                                                        partynode(id = 20L)
                                                                                      )),
                                                                            partynode(id = 21L)
                                                                          ))
                                          )),
                                          partynode(id = 7L, split = sp_DL,
                                                    kids = list(
                                                      partynode(id = 10L, split = sp_OB3, 
                                                                kids = list(
                                                                  partynode(id = 14L, split = sp_OB2,
                                                                            kids = list(
                                                                              partynode(id = 22L),
                                                                              partynode(id = 23L)
                                                                            )),
                                                                  partynode(id = 24L)
                                                                )),
                                                      partynode(id = 11L, split = sp_OB3,
                                                                kids = list(
                                                                  partynode(id = 15L, split = sp_OB2,
                                                                            kids = list(
                                                                              partynode(id = 25L),
                                                                              partynode(id = 26L)
                                                                            )),
                                                                  partynode(id = 27L)
                                                                ))
                                                    ))
                                        )),
                              partynode(id = 5L)
                            )),
                  
                  
                  
                  partynode(id = 3L)
                ))



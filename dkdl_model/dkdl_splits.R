###################################################################
# palliatief verloop ja / nee

sp_palliatief_verloop <- partysplit(varid = which(names(df) == "VR_verloop.4"),
                                    breaks = 0.5)

###################################################################

# specialistisch verpleegtechnische zorgvraag gebaseerd op infuus ja/nee

sp_technisch_infuus <- partysplit(varid = which(names(df) == "VR_technisch_infuusbehandeling"),
                              breaks = 0.5)

###################################################################
# DKDL variant 3

# DKDL variant 3 som score 'draagkracht'
sp_DK <- partysplit(varid = which(names(df) == "DK"),
                          breaks = 6.5) #dk_thresh

# DKDL variant 3 som score 'draaglast'
sp_DL <- partysplit(varid = which(names(df) == "DL"),
                          breaks = 1.5) # dl_thresh

# DKDL Compact som score 'ondersteuningsbehoefte'
sp_OB3 <- partysplit(varid = which(names(df) == "OB"),
                           breaks = 5.5)  # 4,5 ---- 6, 7 etc

sp_OB2 <- partysplit(varid = which(names(df) == "OB"),
                           breaks = 3.5) # 0,1,2,3 ---- 4,5


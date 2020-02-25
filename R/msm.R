

 library(msm)
 library(msm, lib.loc='/your/library/dir')
 cav[1:21,]

 statetable.msm(state, PTNUM, data=cav)

 Q <- rbind ( c(0, 0.25, 0, 0.25),
               c(0.166, 0, 0.166, 0.166),
               c(0, 0.25, 0, 0.25),
               c(0, 0, 0, 0) )

 Q.crude <- crudeinits.msm(state ~ years, PTNUM, data=cav,
                            qmatrix=Q)


 cav.msm <- msm( state ~ years, subject=PTNUM, data = cav,
                  qmatrix = Q, deathexact = 4)

 cav.msm
 plot(cav.msm, legend.pos=c(8, 1))

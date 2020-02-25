library(foreign)
library(xtable)
library(stargazer)
#chap <- read.csv("chap2.csv", header = TRUE)
#new <- chap[c("party", "galtan", "sociallifestyle", "civlib_laworder", "religious_principle", "immigrate_policy", "multiculturalism", "urban_rural", "ethnic_minorities", "deregulation", "nationalism", "econ_interven", "redistribution", "spendvtax", "corrupt_salience", "antielite_salience", "international_security", "environment")]
#new2 <- new[1:243, 2:18]
#fa1 <- factanal(new2, factors = 4, rotation = "varimax", sort = TRUE)
#print(fa1, digits = 3, cutoff = .5, sort = TRUE)

#newobject2 <- as.data.frame(unclass(fa1$loadings))
newobject2<-sim.data0ct[sim.data0ct$nid==3,]
xtable(newobject2, type = "latex", file = "filename2.tex")

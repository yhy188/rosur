#the survival curve for every patient
library(survival)
library(survminer)
library(survRM2)
library(readxl)
#datasample <- read.csv("~/Downloads/Rpkg/rosur/clinical.mulevents.csv")
#datasample<-sim.data0ct
datasample<-sim.data01ct
head(datasample)
my.surv <- Surv(datasample$time,datasample$status)
fit <- survfit(formula = Surv(datasample$time,datasample$status)~nid,data=datasample)
n <- factor(datasample$nid)
head(n)
plot(fit,main = "the Survival Curve",xlab="time",ylab = "survival probability")

#mean, toy examples

singledata <- read_excel("~/Downloads/Rpkg/rosur/singledata.xlsx")
head(singledata)
time   = singledata$time
status = singledata$status
nid    = singledata$nid
obj2 = rmst2(time, status, nid)
print(obj2)
plot(obj2, xlab="Days", ylab="Probability")


##########

#sim.data0ct[sim.data0ct$nid==1,]
#write.csv(sim.data0ct,"~/Downloads/Rpkg/rosur/sim.data0ct.csv")

singledata <-read.csv("~/Downloads/Rpkg/rosur/sim.data0ct.csv")
head(singledata)
time   = singledata$time
#tau=min(max(singledata[singledata$treat==1,singledata$time]),
#        max(singledata[singledata$treat==0,singledata$time]))
status = singledata$status
arm    = singledata$treat
x      = singledata$x
#--- without covariates ----

obj2 = rmst2(time, status, arm)
#a=rmst2(time, status, arm, tau=10)

print(obj2)
plot(obj2, xlab="Days", ylab="Probability", density=60)
#--- with covariates ----
#obj2x = rmst2(time, status, arm, tau=10,covariates=x)
#a=rmst2(time, status, arm, tau=10, covariates=x)
#lines(obj2x, xlab="Days", ylab="Probability", density=60)


######

head(obj2$RMST.arm0$result)
#arm0sum<-data.frame(obj2$RMST.arm0$result[1,1:2])
arm0sum<-(obj2$RMST.arm0$result[1,1:2])
head(obj2$RMST.arm1$result)
arm1sum<-data.frame(obj2$RMST.arm1$result[1,1:2])
arm1sum<-(obj2$RMST.arm1$result[1,1:2])
arm.sum<-cbind(arm0sum,arm1sum)
arm.sum
arm.sum.tab<-data.frame(arm.sum[1,1],arm.sum[2,1], arm.sum[1,2],arm.sum[2,2])
names(arm.sum.tab)<-c("con.e", "con.se", "tre.e","tre.se")
# Want to get the standard dervation of the curve, rather than the estimated se.
#How to get the sd of the curves.
arm.sum.tab



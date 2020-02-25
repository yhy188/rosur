#?????˵?????????
library(survival)
library(DTR)
attach(WRSE)
head(WRSEdata)
WRSE<-lung
my.surv1 <- Surv(heart$start, heart$stop, heart$event)
head(heart)
summary(my.surv1)
  #Surv(WRSE$U,WRSE$delta)
fit1 <- survfit(formula = my.surv1,data = heart)
plot(fit1,main="the Survival Curve",xlab = "time",ylab = "survival probality")

#??????????
y <- 1
x <- c(WRSE$U)
area <- x*y
area

#????
funx <- function(x){
  {

    if (x <= WRSE$U){
    y=1
  }
  else {
    y=0
  }
  return(y)
  }
}
point <- c(funx(70),funx(140),funx(210),funx(280),funx(350),funx(420),funx(490),funx(560),funx(630),funx(700))
variance <- var(point)
variance



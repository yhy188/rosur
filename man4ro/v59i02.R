### Load package
library("survsim")

### 3. Simple survival data (Section 3.3, pp. 5-6)
dist.ev <- "weibull"
anc.ev <- 1
beta0.ev <- 5.268
dist.cens <- "weibull"
anc.cens <- 1
beta0.cens <- 5.368
x <- list(c("bern", 0.3), c("bern", 0.4))
beta <- list(-0.4, -0.25)
set.seed(11092014)
simple.dat <- simple.surv.sim(300, 365, dist.ev, anc.ev,
                              beta0.ev, dist.cens, anc.cens,
                              beta0.cens, , beta, x)

summary(simple.dat)
head(simple.dat)
### 4. Multiple event survival data (Section 4.3, pp. 8-10)
dist.ev <- c("weibull", "llogistic", "weibull")
anc.ev <- c(0.8, 0.9, 0.82)
beta0.ev <- c(3.56, 5.94, 5.78)
beta <- list(c(-0.04, -0.02, -0.01), c(-0.001, -8e-04, -5e-04), c(-0.7, -0.2, -0.1))
x <- list(c("normal", 26, 4.5), c("unif", 50, 75), c("bern", 0.25))
set.seed(11092014)
clinical.data <- mult.ev.sim(n = 2000,
  foltime = 400,
  dist.ev,
#  dist.ev=c('llogistic','weibull', 'weibull','weibull'),
#            ,'weibull','weibull', 'weibull','weibull'),
  anc.ev,
  beta0.ev,
  dist.cens = "weibull",
  anc.cens = 1,
  beta0.cens = 5.2,
  #z=NA, #
  z = list(c("unif", 0.6, 1.4)),
  #z = c("unif", 0.6, 0.4),
  beta, x, nsit = 3)# nsit=size(dist.ev)
head(round(clinical.data, 2))
summary(clinical.data)

write.csv(clinical.data,"clinical.mulevents.csv")
### 5. Recurrent event survival data (Section 5.3, pp. 13-16)
dist.ev <- c("lnorm", "llogistic", "weibull", "weibull")
anc.ev <- c(1.498, 0.924, 0.923, 1.051)
beta0.ev <- c(7.195, 6.583, 6.678, 6.43)
anc.cens <- c(1.272, 1.218, 1.341, 1.484)
beta0.cens <- c(7.315, 6.975, 6.712, 6.399)
beta <- list(c(-0.4, -0.5, -0.6, -0.7))
lambda <- c(2.18, 2.33, 2.40, 3.46)
set.seed(11092014)
sim.data <- rec.ev.sim(n = 500, foltime = 3600, dist.ev, anc.ev, beta0.ev, , anc.cens,
  beta0.cens, z = c("unif", 0.8, 1.2), beta, x = list(c("bern", 0.5)), lambda,
  priskb = 0.5, max.old = 730)
head(sim.data)
sim.data[sim.data$nid == 251, ]
summary(sim.data)

### 7. Aggregated data (Section 7.1, pp. 18)
agg.data <- accum(sim.data)
head(agg.data)

### 8. Application (Section 8, pp. 18-19)
library("survival")
library("MASS")
single <- coxph(Surv(start, stop, status) ~ as.factor(x) + as.factor(x.1), data = simple.dat)
multiple <- coxph(Surv(start, stop, status) ~ strata(ev.num)/(x + x.1 + as.factor(x.2)) +
  cluster(nid), data = clinical.data)
AG.event <- coxph(Surv(start2, stop2, status) ~ as.factor(x) + cluster(nid), data = sim.data)
nb <- glm.nb(obs.ep.accum ~ as.factor(x) + offset(log(time.accum)), data = agg.data)






########
### A cohort with 1000 subjects, with a maximum follow-up time of 3600 days and two
### covariates, following a Bernoulli and uniform distribution respectively, and a
### corresponding beta of -0.4, -0.5, -0.6 and -0.7 for each event for the first
### covariate and a corresponding beta of 0, 0, 0 and 1 for each event for the
### second covariate. Notice that the time to censorship is assumed to follow a
### Weibull distribution, as no other distribution is stated and random effect is
### the same for all events.

sim.data <- mult.ev.sim(n=1000, foltime=3600,
                        dist.ev=c('llogistic','weibull', 'weibull','weibull'),
                        anc.ev=c(0.69978200185280, 0.79691659193027,
                                 0.82218416457321, 0.85817155198598),
                        beta0.ev=c(5.84298525742252, 5.94362650803287,
                                   5.78182528904637, 5.46865223339755),
                        #,
                        dist.cens = "weibull",
                        anc.cens=1.17783687569519,
                        beta0.cens=7.39773677281100,
                        z=list(c("unif", 0.8,1.2)),
                        beta=list(c(-0.4,-0.5,-0.6,-0.7),c(0,0,0,1)),
                        x=list(c("bern", 0.5), c("unif", 0.7, 1.3)),
                        nsit=4)

summary(sim.data)
head(sim.data,20)


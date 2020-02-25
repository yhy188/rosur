load("dli.data.rda")

require("etm")


###################################################
### Computation of the transition probabilities ###
###################################################

### Matrix specifying the possible transitions

tra <- matrix(FALSE, 9, 9,
              dimnames = list(as.character(0:8), as.character(0:8)))
tra[1, 2:3] <- TRUE
tra[3, 4:5] <- TRUE
tra[5, 6:7] <- TRUE
tra[7, 8:9] <- TRUE

### computation of the transition probabilities
dli.etm <- etm(dli.data, as.character(0:8), tra, "cens", s = 0)


### basic xyplot of all direct transitions
xyplot(dli.etm, lwd = 2)


############
### CLFS ###
############

### Computation of the clfs + var clfs
clfs <- dli.etm$est["0", "0", ] + dli.etm$est["0", "6", ]
var.clfs <- dli.etm$cov["0 0", "0 0", ] +
    dli.etm$cov["0 6", "0 6", ] + 2 * dli.etm$cov["0 0", "0 6", ]

## computation of the 95% CIs + plot
ciplus <- clfs + qnorm(0.975) * sqrt(var.clfs)
cimoins <- clfs - qnorm(0.975) * sqrt(var.clfs)

plot(dli.etm$time, clfs, type = "s", bty = "n", ylim = c(0, 1),
     xlab = "Year", ylab = "Probability")
lines(dli.etm$time, cimoins, lty = 3, type = "s")
lines(dli.etm$time, ciplus, lty = 3, type = "s")


### Plots of P_{0j}, j = 1,..., 8
choice <- rownames(dli.etm$cov)[(grep("^0", rownames(dli.etm$cov)))][-1]
plot(dli.etm, tr.choice = choice, col = seq_along(choice), xlab = "Year",
     lty = rep(1, length(choice)), bty = "n", ylim = c(0, 0.6), 
     curvlab = paste("state", as.character(1:8)), ncol = 2)


### Computation of the transition probabilities
### stratified on disease stage before transplant 
tr.early <- etm(dli.data[dli.data$distatpr == 1, ], as.character(0:8),
                tra, "cens", 0, cova = FALSE)
tr.int <- etm(dli.data[dli.data$distatpr == 2, ], as.character(0:8),
                tra, "cens", 0, cova = FALSE)
tr.adv <- etm(dli.data[dli.data$distatpr == 3, ], as.character(0:8),
                tra, "cens", 0, cova = FALSE)


## Computation of the CLFSs
CLFS <- function(obj) {
    clfs <- obj$est["0", "0", ] + obj$est["0", "6", ]
    var <- obj$cov["0 0", "0 0", ] + obj$cov["0 6", "0 6", ] +
        2 * obj$cov["0 0", "0 6", ]
    list(clfs, var)
}

clfs.early <- CLFS(tr.early)
clfs.int <- CLFS(tr.int)
clfs.adv <- CLFS(tr.adv)

plot(tr.early$time, clfs.early[[1]], col = 1, type = "s", 
     ylim = c(0, 1), bty = "n", xlab = "Year", 
     ylab = "Current Leukaemia Free Survival")
lines(tr.int$time, clfs.int[[1]], col = 2, type = "s")
lines(tr.adv$time, clfs.adv[[1]], col = 3, type = "s")
legend("topright", c("Early", "Intermediate", "Advanced"),
       col = c(1, 2, 3), lty = c(1, 1, 1), bty = "n")

# rosur: Robust policy for  minizaing Cox Proportional Hazards with  optimal retargeting

Policy learning can be used to extract individualized treatment regimes from observational data in healthcare, civics, e-commerce, and beyond. 
One big hurdle to policy learning is a commonplace lack of overlap in the data for different actions, which can lead to unwieldy policy evaluation and poorly performing learned policies.
Furthermore, the data of survival analysis are often right-censored, and the outcomes are filled with missing due to the repeatable units for multiple treatments.

With such data set of survival analysis, we proposed the method of  the robust policy for treatment assignment with minimizing Cox proportional hazards.
The missing data were estimated with inverse probability-weighted estimators and the survival time was estimated with the Cox model for individual units with the informative censoring assumption.
With survival function estimation of the individual units, we obatined the paramenters of the restricted mean survival time and the variance as the dual respoones for each unit. 

Then, we contruct the robust optimization model for minizaing Cox Proportional Hazards with  optimal retargeting. This model is to find the best subset of units for maximum (or minimum) average treatment effect while controlling their uncertainty. The acceptable uncertainty set was identified by the confidence interval. 
We study a solution to this problem based on retargeting, that is, changing the population on which policies are optimized.  This solution is effective with the context of the treatment are preset or set with randomization.
With the potential missing data, the tuition of this method is to re-weight the units with the robust optimization model after the inverse probability-weighted estimation. 
Moreover, the lack of overlap had been mitigated with the inverse probability-weighted and reweighting procedures. 

We further consider weights that additionally control for potential bias due
to retargeting. At the population level, retargeting may induce little to no bias.  This approach is justified via a finite sample upper bound on the difference between the mean response due to the estimated individualized treatment rule and the mean response due to the optimal individualized treatment rule.
We demonstrate the utility of this approach by applying these models to a real data. 

This model on  finding an interpretable subset (with maximum average treatment effect and  minimum vairance) can be applied in many scenarios, such as identifying exceptional responders in randomized trials. 

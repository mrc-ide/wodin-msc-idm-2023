##Differential equations

deriv(S_f) <- -betaMW_1c*pcr_1c*S_f*I_m/N_m + recovery_1c*I_f
deriv(S_m) <- -betaWM_1c*pcr_1c*S_m*I_f/N_f + recovery_1c*I_m

deriv(I_f) <- betaMW_1c*pcr_1c*S_f*I_m/N_m - recovery_1c*I_f
deriv(I_m) <- betaWM_1c*pcr_1c*S_m*I_f/N_f - recovery_1c*I_m


##Initial conditions

initial(S_f) <- 99990
initial(S_m) <- 99990

initial(I_f) <- 10
initial(I_m) <- 10


##Other equations

N_f <- S_f+I_f
N_m <- S_m+I_m
N_tot <- N_f+N_m



##Parameter values

pcr_1c <-user(2)		#partner change rate
betaMW_1c <- user(0.5)  	#per partner STI transmission probability, male to female
betaWM_1c <- user(0.5)  	#per partner STI transmission probability, female to male
recovery_1c <- user(2)          #recovery rate of infection per person per year (1/mean duration in years)


##Additional outputs

output(PopSize) <- N_f+N_m
output(prevalence_f) <- I_f/N_f
output(prevalence_m) <- I_m/N_m
output(prevalence_tot) <- (I_f+I_m)/N_tot
output(newInf_f) <- betaMW_1c*pcr_1c*S_f*I_m/N_m
output(newInf_m) <- betaWM_1c*pcr_1c*S_m*I_f/N_f
output(incidence_tot) <- betaMW_1c*pcr_1c*S_f*I_m/N_m + betaWM_1c*pcr_1c*S_m*I_f/N_f

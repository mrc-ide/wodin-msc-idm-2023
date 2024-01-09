## Oncho complete example 1 ##

deriv(W)<-((deltaH0 + deltaHinfinity * CH * ABR * L)/(1 + CH * ABR * L)) * ABR * L - (sigmaW +  muH) * W

deriv(M)<-((1/2) * phi * F) * W - (sigmaM + muH) * M

deriv(L)<-(deltaV0/(1 + CV0 * M)) * beta * M - (sigmaL + muV + alphaV0 * M + (aH/g)) * L

initial(W) <- 10
initial(M) <- 0
initial(L) <- 0

P <- 100 * (1 - (1 + M/(k0*M^k1))^(-k0*M^k1)) 

ATP <- ABR * L



deltaH0 <- aH*sH 

aH <- user(0.8) 

sH <- user(0.2) 

deltaHinfinity <- user(0.0032) 

CH <- user(0.0137) 

muH <- user(0.02) 

sigmaW <- user(0.1) 

sigmaM <- user(0.8) 

sigmaL <- user(104) 

phi <- user(1) 

F <- user(0.6674) 

k0 <- user(0.0553) 

k1 <- user(0.491) 

deltaV0 <- aV*sV0 

aV <-user(0.4481) 

sV0 <-user(0.0463) 

CV0 <- aV*c 

c <- user(0.0196) 

alphaV0 <- aV*alpha 

alpha <- user(0.8653) 

beta <- h/g 

h <- user(0.3) 

g <- user(0.0096) 

muV <- user(52) 

ABR <- user(1000) 

output(P) <- P 

output(ATP) <-ATP 
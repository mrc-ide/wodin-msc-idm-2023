r <- user(0.1)    # Growth rate
s <- user(0.06)   # Death rate
N_init <- user(1) # Initial population size

dt <- 0.01
time <- step * dt

# Deterministic solution - often unobtainable for non-linear models
initial(N_det) <- N_init
update(N_det) <- N_init * exp((r - s) * time)

# Stochastic solution with initial condition, number of births in time
# t to t + dt and then update to next step

initial(N) <- N_init

# How many events happen in total (births and deaths)?
growthAndDeath <- rbinom(N, (r + s) * dt)

# How many of these events were deaths?
death <- rbinom(growthAndDeath, s / (r + s))
growth <- growthAndDeath - death

update(N) <- N + growth - death

# Track if the population has gone extinct:
initial(extinct) <- N == 0
update(extinct) <- N == 0

r <- user(0.1)    # Birth rate
mu <- user(0.06)   # Mortality rate
N_init <- user(1) # Initial population size

# The step size, in units of time
dt <- 0.01
# The current time is the number of steps taken multiplied by the step size
time <- step * dt

# Deterministic solution (often unobtainable for non-linear models)
initial(N_det) <- N_init
update(N_det) <- N_init * exp((r - mu) * time)

# Stochastic solution with initial condition, number of births in time
# t to t + dt and then update to next step

initial(N) <- N_init

# How many events happen in total (births and deaths)?
growthAndDeath <- rbinom(N, (r + mu) * dt)

# How many of these events were deaths?
death <- rbinom(growthAndDeath, mu / (r + mu))
growth <- growthAndDeath - death

update(N) <- N + growth - death

# Track if the population has gone extinct:
initial(extinct) <- N == 0
update(extinct) <- N == 0

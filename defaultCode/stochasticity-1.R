r <- user(0.1)    # Birth rate
N_init <- user(1) # Initial population size

# The step size, in units of time
dt <- 0.01
# The current time is the number of steps taken multiplied by the step size
time <- step * dt

# Deterministic solution
initial(N_det) <- N_init
update(N_det) <- N_init * exp(r * time)

# Stochastic solution
initial(N_stoch) <- N_init

# We can use rbinom to generate N_stoch random samples from the 
# binomial distribution with probability r * dt
n_birth <- rbinom(N_stoch, r * dt) 

update(N_stoch) <- N_stoch + n_birth

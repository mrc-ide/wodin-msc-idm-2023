beta <- user(0.5)  # Contact rate
sigma <- user(0.3) # Recovery rate
N <- user(1000)    # Total population size

initialise_at_steady_state <- user(1, integer = TRUE, min = 0, max = 1)

I_init <- user(1)

# Steady-state prevelance
I_star <- if (beta > sigma) N * (beta - sigma) / beta else 0

dt <- 0.01
time <- step * dt

# Stochastic solution
initial(I) <- if (initialise_at_steady_state == 1) round(I_star) else I_init

FOI <- beta * I / N

# Susceptible population can be derived from the difference between
# constant total population and the number of infected individuals
initial(S) <- N - I
update(S) <- N - I

n_infections <- rbinom(S, FOI * dt)
n_recoveries <- rbinom(I, sigma * dt)

update(I) <- I + n_infections - n_recoveries

# Deterministic solution
initial(I_det) <- I
update(I_det) <- if (initialise_at_steady_state) I_star else
  (I_star / (1 + (I_star / I_init - 1) * exp(-(beta - sigma) * time)))

initial(extinct) <- I == 0
update(extinct) <- I == 0

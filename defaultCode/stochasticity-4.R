beta <- user(0.5)      # Contact rate
sigma <- user(0.3)     # Recovery rate
mu <- user(0.00038)    # Death rate
prop_immune <- user(0) # Proportion of population initially immune
N <- user(10000)       # Total population.
I_init <- user(5)      # Initial infecteds

# Derive initial susceptibles from this:
S_init <- (N - I_init) * (1 - prop_immune)

initialise_at_steady_state <- user(0, integer = TRUE, min = 0, max = 1)

dt <- 0.01

# Steady-state prevelance
R0 <- beta / (sigma + mu)
# Number of infecteds at endemic equilibrium state
I_star <- N * mu * (beta - sigma - mu) / (beta * (mu + sigma))
# Number of susceptibles at endemic equilibrium state
S_star <- N / R0

# Stochastic solution
initial(S) <- if (initialise_at_steady_state == 1) round(S_star) else S_init
initial(I) <- if (initialise_at_steady_state == 1) round(I_star) else I_init
initial(R) <- if (initialise_at_steady_state == 1) N - round(I_star) - round(S_star) else N - I_init - S_init

FOI <- beta * I / N

# Two types of events for S, so competing hazards.
n_events_S <- rbinom(S, (FOI + mu) * dt)
# A fraction of S events are deaths...
n_deaths_S <- rbinom(n_events_S, mu/(FOI + mu))
# ...and the rest are infections.
n_infections_S <- n_events_S - n_deaths_S

# Two types of events for I, so competing hazards.
n_events_I <- rbinom(I, (sigma + mu) * dt)
# A fraction of I events are deaths...
n_deaths_I <- rbinom(n_events_I, mu / (mu + sigma))
# ...the rest are recoveries.
n_recoveries_I <- n_events_I - n_deaths_I

n_deaths_R <- rbinom(R, mu * dt)
n_births <- n_deaths_S + n_deaths_I + n_deaths_R

# update for next time step
update(S) <- S - n_deaths_S - n_infections_S + n_births
update(I) <- I + n_infections_S - n_recoveries_I - n_deaths_I
update(R) <- R + n_recoveries_I - n_deaths_R

initial(extinct) <- I == 0
update(extinct) <- I == 0

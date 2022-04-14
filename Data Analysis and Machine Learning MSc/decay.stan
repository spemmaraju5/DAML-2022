data {
    int<lower=1> N_widgets; // number of widgets



    // Time of measurement.
    vector[N_widgets] t_measured;

    // Amount of material measured is uncertain.
    vector[N_widgets] N_measured;
    vector[N_widgets] sigma_N_measured;

    // Maximum amount of initial material.
    real N_initial_max;

    // Max time of manufacture (35 days converted to seconds)
    real t_initial_max;
}

parameters {
    // The decay rate parameter.
    real<lower=0> alpha;

    // The amount of initial material is not known.
    vector<lower=0, upper=N_initial_max>[N_widgets] N_initial;

    // Time of manufacture.
    vector<lower=0, upper=t_initial_max>[N_widgets] t_initial;
}

model {
    for (i in 1:N_widgets) {
        N_measured[i] ~ normal(
          N_initial[i] * exp(-alpha * (t_measured[i] - t_initial[i])), 
          sigma_N_measured[i]
        );
    }
}
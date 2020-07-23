data {
  // Number of RNAs
  int<lower=1> n;     
  
  // Note: These are all integers
  // columns t, s, p
  int<lower=0> Tot[n];
  int<lower=0> Sup[n];
  int<lower=0> Pellet[n];
}
parameters {
  // Unnormalized mixing proportions
  // real<lower=0> mixing_t;
  real<lower=0> scaling_factor_sup;
  real<lower=0> scaling_factor_pellet;
  
  // dispersion parameter for counts
  real phi;
}
model{
  // mixing ratios
  scaling_factor_sup ~ gamma(1,1);
  scaling_factor_pellet ~ gamma(1,1);
  // Cauchy prior for negbin dispersion parameter
  phi ~ cauchy(0,3);
  
  for(idx in 1:n){ 
    // count distn negative binomial with specified means
    // Total
    Tot[idx] ~ neg_binomial_2(scaling_factor_sup * Sup[idx] + scaling_factor_pellet * Pellet[idx], phi);
  }
}

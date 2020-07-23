#' Model fit
#' 
#' Fit the bayesian statistical model to the counts data.
#' @details The input data should be the wide format in terms of fractions.
#' It will be coverted to a list of vectors through the function compose_data from 
#' package tidybayes for model fitting. Compile_model is the pre_loaded data that 
#' stores the compiled bayesian statistical model.
#' 
#' @param wide_data A wider data frame
#' @param chains A number, defaulting to 4
#' @param iter A number, defaulting to 1000
#' @param control A list of parameters, defaulting to list(adapt_delta = 0.85)
#' @param ... Other arguments passed to `rstan::sampling` (e.g. warmup, seed).
#' @return An object of class `stanfit` returned by `rstan::sampling`
#' @seealso [rstan::sampling()], `browseVignettes("rstan")`
#' @keywords model fit
#' @import tidybayes
#' @importFrom rstan stan_model sampling summary
#' @export
#' @examples  
#' model_fit(wide_data, chains = 1, iter = 500)
#' \dontrun{
#' model_fit(wide_data)
#' model_fit(wide_data, chains = 4)
#' model_fit(wide_data = mydata, iter = 1500, control = list(adapt_delta = 0.85))
#' }
#' 
model_fit <- function(wide_data, chains = 4, 
                      iter = 1000, control = list(adapt_delta = 0.85),...)
{
  reformated_wide_data <- tidybayes::compose_data(wide_data)
  model_sampling <- rstan::sampling(stanmodels$RNAFracQuant, data = reformated_wide_data,
                             chains = chains, iter = iter, 
                             control = control,...=...)
  return(model_sampling)
}


#' parameters statistical results
#' 
#' Get the estimated statistical results of parameters
#' @details The input data should be the wide format in terms of fractions.
#' Function model_fit from this package is called in this function.
#' Output a data frame that includes a statistical result of parameters.
#' @param wide_data A wider data frame
#' @param chains A number, default to 4
#' @param iter A number, default to 1000
#' @param control A list of parameters, default to list(adapt_delta = 0.85)
#' @param ... Other arguments passed to `rstan::sampling` (e.g. warmup, seed).
#' @return A data frame
#' @seealso [rstan::sampling()], `browseVignettes("rstan")`
#' @keywords parameter estimation
#' @import dplyr
#' @export
#' @examples 
#' get_para_sta(wide_data, chains = 1, iter = 500)
#' \dontrun{
#' get_para_sta(wide_data)
#' get_para_sta(wide_data, chains = 4)
#' get_para_sta(wide_data, iter = 1500, control = list(adapt_delta = 0.85))
#' get_para_sta(wide_data, control = list(adapt_delta = 0.85))
#' }
get_para_sta <- function(wide_data, chains = 4, iter = 1000, control = list(adapt_delta = 0.85),...)
{
  para_sta <- model_fit(wide_data, chains = chains, iter = iter, control = control,...=...) %>% 
    rstan::summary()
  summary_result <- para_sta[['summary']]
  result <- data.frame(scaling.factor.Sup = summary_result["scaling_factor_sup", 
                                                           "50%"], 
                       scaling.factor.Pellet = summary_result["scaling_factor_pellet",
                                                              "50%"], 
                       lp.n_eff = summary_result["lp__", 
                                                 "n_eff"], 
                       lp.Rhat = summary_result["lp__", 
                                                "Rhat"])
  return(result)
}


#' Get parameters'estimation per condition
#' 
#' Get the estimated statistical results of parameters for each condition.
#' @details The input data should be the wide format in terms of fractions.
#' Function get_para_sta from this package is called in this function. Output 
#' a data frame that includes a statistical result of parameters for each condition.
#' @param wide_data A wider data frame
#' @param chains A number, default to 4
#' @param iter A number, default to 1000
#' @param control A list of parameters, default to list(adapt_delta = 0.85)
#' @param ... Other arguments passed to `rstan::sampling` (e.g. warmup, seed).
#' @seealso [rstan::sampling()], `browseVignettes("rstan")`
#' @keywords parameter estimation Condition
#' @importFrom plyr ddply
#' @export
#' @examples  
#' get_paras_median(wide_data, chains = 1, iter = 500)
#' \dontrun{
#' get_paras_median(wide_data)
#' get_paras_median(wide_data, chains = 4)
#' get_paras_median(wide_data, iter = 1500, control = list(adapt_delta = 0.85))
#' get_paras_median(wide_data, control = list(adapt_delta = 0.85))
#' }
get_paras_median <- function(wide_data, chains = 4, 
                             iter = 1000, control = list(adapt_delta = 0.85),...)
{
  plyr::ddply(wide_data, ~Condition, get_para_sta, chains = chains, 
              iter = iter, control = control,...=...)
}

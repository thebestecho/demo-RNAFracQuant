#' Calculate pSup
#' 
#' Calculate the proportion of each transcript in the Supernatant.
#' @details The input data should be the wide format in terms of fractions.
#' Function get_paras_median from this package is called in this function. Output
#' a data frame that includes a variable pSup calculated for each transcript.
#' @param wide_data A wider data frame
#' @param chains A number, default to 4
#' @param iter A number, default to 1000
#' @param control A list of parameters, default to list(adapt_delta = 0.85)
#' @seealso [rstan::sampling()], `browseVignettes("rstan")`
#' @keywords pSup proportion supernatant pellet
#' @import dplyr
#' @importFrom dplyr left_join
#' @export
#' @examples  
#' \dontrun{
#' calculate_pSup(wide_data)
#' calculate_pSup(wide_data = mydata)
#' }
calculate_pSup <- function(wide_data, chains = 4, 
                           iter = 1000, control = list(adapt_delta = 0.85))
{
  paras_median = get_paras_median(wide_data,chains = chains, 
                                  iter = iter, control = control)
  wide_data_pSup <- wide_data %>%
    dplyr::left_join(select(paras_median,Condition,scaling.factor.Sup,scaling.factor.Pellet)) %>%
    mutate(pSup=scaling.factor.Sup*Sup/(scaling.factor.Sup*Sup+scaling.factor.Pellet*Pellet))
}


#' Represent pSup for each transcript
#' 
#' Clear format to represent the proportion of each transcript in the Supernatant.
#' @details The input data should be the wide format in terms of fractions.
#' Function calculate_pSup from this package is called in this function. Output 
#' a data frame that shows the pSup value of each transcript in each fraction.
#' @param wide_data A wider data frame
#' @param chains A number, default to 4
#' @param iter A number, default to 1000
#' @param control A list of parameters, default to list(adapt_delta = 0.85)
#' @seealso [rstan::sampling()], `browseVignettes("rstan")`
#' @keywords pSup supernatant
#' @import dplyr
#' @importFrom tidyr pivot_wider
#' @export
#' @examples  
#' \dontrun{
#' each_mRNA_pSup(wide_data)
#' each_mRNA_pSup(wide_data = mydata)
#' }
each_mRNA_pSup <- function(wide_data, chains = 4, 
                           iter = 1000, control = list(adapt_delta = 0.85))
{
  calculate_pSup(wide_data,chains = chains, 
                 iter = iter, control = control) %>%
    select(-scaling.factor.Pellet,-scaling.factor.Sup,-Tot,-Sup,-Pellet) %>%
    pivot_wider(names_from = Condition,values_from = pSup)
}


#' Write results into files
#' 
#' @details This function takes the outputs of functions in RNAFracQuant as the input arguments 
#' and then writes them into text files under the same "Results" directory.
#' @param ... Unlimited arguments, which are supposed to be data frames.
#' @seealso [readr::write_tsv()], `browseVignettes("readr")`
#' @keywords results
#' @importFrom here here
#' @importFrom readr write_tsv
#' @export
#' @examples  
#' \dontrun{
#' write_results(paras_median, data_pSup)
#' write_results(data1, data2, data3, data4)
#' }
write_results <- function(...){
  dir.create("Results")
  dir <- ("Results")
  dots <- substitute(list(...))
  name <- sapply(dots, deparse)[-1]
  for(i in 1:length(list(...))){
    readr::write_tsv(list(...)[[i]],
              file.path(dir, paste0(name[[i]],".txt")))
  }
}

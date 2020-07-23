#' Read Samplesheet
#' 
#' Read the Samplesheet file that is provided by users.
#' @details This function is to read the samplesheet file that is provided by users.
#' Useres need to make sure that the input directory is under the working directory 
#' and the samplesheet file is in the input directory.
#' @param dir_in The input directory name
#' @param file The input Samplesheet file name
#' @return A single data frame
#' @keywords samplesheet
#' @importFrom readr read_tsv
#' @export
#' @examples  
#' \dontrun{
#' read_samplesheet("inst/extdata","Samplesheet")
#' read_samplesheet(dir_in = "inst/extdata",file = "Samplesheet")
#' }
#' samplesheet_example
read_samplesheet <- function(dir_in,file)
{
  load_samplesheet = read_tsv(paste(dir_in, file, sep = "/"), comment = "#")
  return(load_samplesheet)
}


#' Read count files
#' 
#' Read all the count file that are provided by users.
#' @details This function is to read the samplesheet file that is provided by users
#' and then use it to read all the count files. Useres need to make sure that the 
#' samplesheet file and all the count files are within the same input directory.
#' @param dir_in The input directory name
#' @param file The input Samplesheet file name
#' @keywords counts
#' @importFrom readr read_tsv
#' @export
#' @examples 
#' \dontrun{
#' read_count_files("inst/extdata","Samplesheet")
#' read_count_files(dir_in = "inst/extdata",file = "Samplesheet")
#' }
read_count_files <- function(dir_in, file)
{
  count_data = read_samplesheet(dir_in,file) %>%
    dplyr::group_by_all() %>%
    do(read_tsv(paste(dir_in, .$File[1], sep = "/"),col_names = c("ORF", "Count")))
}


#' Change the data format
#' 
#' Covert the long Fraction coloum to the wide format.
#' @details In this function, function read_count_files from this package is called.
#' Output a wider data frame for representing the count value of each trancript
#' for each fraction.
#' @param dir_in The input directory name
#' @param file The input Samplesheet file name
#' @keywords counts each fraction
#' @import dplyr tidyr
#' @export
#' @examples 
#' \dontrun{
#' get_wide_Fraction("inst/extdata","Samplesheet")
#' get_wide_Fraction(dir_in = "inst/extdata", file = "Samplesheet.txt")
#' }
get_wide_Fraction <- function(dir_in, file)
{
  data <- read_count_files(dir_in, file) %>%
    ungroup() %>%
    #' ## Select the columns that we need
    select(Condition,Fraction,ORF,Count) %>%
    #' ## Generate a wider data format to get the variables of fractions
    pivot_wider(names_from = Fraction,values_from = Count)
}

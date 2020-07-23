context("test reading files from users")

DATA_DIR <- system.file("extdata/", package = "RNAFracQuant")

test_that("reading samplesheet stops when there are wrong input arguments", {
  
  expect_error( read_samplesheet(DATA_DIR) )
  expect_error( read_samplesheet("Samplesheet") )
  expect_error( read_samplesheet("inst","Samplesheet") )
  expect_error( read_samplesheet("inst/extdata","samplesheet") )
  
})

test_that("reading sampleseet works for example data", {
  
  expect_equal( typeof(read_samplesheet(DATA_DIR,"Samplesheet")), "list" )
  
})

test_that("there is information required in the samplesheet file", {
  
  samplesheet <- read_samplesheet(DATA_DIR,"Samplesheet")
  column_names <- paste( unlist(colnames(samplesheet)), collapse=' ')
  expect_match( column_names, "Condition" )
  expect_match( column_names, "Fraction" )
  expect_match( column_names, "File" )
  
})

test_that("reading count files stops when it should", {
  
  expect_error( read_count_files(DATA_DIR) )
  expect_error( read_count_files("Samplesheet") )
  expect_error( read_count_files("inst","Samplesheet") )
  expect_error( read_count_files("inst/extdata","samplesheet") )
  
})

test_that("reading count files in the right format", {
  
  count_data <- read_count_files(DATA_DIR,"Samplesheet")
  expect_equal( typeof(count_data$ORF), "character" )
  expect_equal( typeof(count_data$Count), "double" )
  
})

test_that("function get_wide_Fraction stops when there are wrong input arguments", {
  
  expect_error( get_wide_Fraction(DATA_DIR) )
  expect_error( get_wide_Fraction("Samplesheet") )
  expect_error( get_wide_Fraction("inst","Samplesheet") )
  expect_error( get_wide_Fraction("inst/extdata","samplesheet") )
  
})

test_that("the columns that we need in the data frame are selected", {
  
  wide_data <- get_wide_Fraction(DATA_DIR,"Samplesheet")
  col_names <- paste( unlist(colnames(wide_data)), collapse=' ')
  expect_match( col_names, "Condition" )
  expect_match( col_names, "ORF" )
  expect_equal( is.element("Count", col_names), FALSE)
  expect_equal( is.element("Fraction", col_names), FALSE)
  
})

test_that("there is at least one fraction", {
  
  wide_data <- get_wide_Fraction(DATA_DIR,"Samplesheet")
  expect_equal( ncol(wide_data) >= 3, TRUE )
  
})

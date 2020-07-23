context("test pSup calculation and representation")

test_that("function stops when there are wrong input arguments", {
  
  expect_error( calculate_pSup() )
  expect_error( calculate_pSup( chains = 4 ) )
  expect_error( calculate_pSup( wide_data, chains ) )
  expect_error( calculate_pSup( wide_data, control ) )
  
  expect_error( each_mRNA_pSup() )
  expect_error( each_mRNA_pSup( chains = 4 ) )
  expect_error( each_mRNA_pSup( wide_data, chains ) )
  expect_error( each_mRNA_pSup( wide_data, control ) )
  
  expect_error( write_results() )
  expect_error( write_results(paras_median = data1) )
  expect_error( write_results(mRNA_pSup = data2) )
  
})

test_that("pSup calculation works for sample data", {
  
  data_pSup <- calculate_pSup(wide_data, chains = 1, iter = 100)
  col_names <- paste( unlist(colnames(data_pSup)), collapse=' ')
  expect_match( typeof(data_pSup), "list" )
  expect_match( col_names, "pSup" )
  expect_equal( TRUE %in% complete.cases(data_pSup[['pSup']]), TRUE )
  
})

test_that("representing pSup for each mRNA works for sample data", {
  
  data_each_mRNA_pSup <- each_mRNA_pSup(wide_data, chains = 1, iter = 100)
  col_names <- paste( unlist(colnames(data_each_mRNA_pSup)), collapse=' ')
  expect_equal( is.element("Condition", col_names), FALSE)
  expect_equal( is.element("pSup", col_names), FALSE)
  
})

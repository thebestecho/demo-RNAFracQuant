context("test model fitting")

test_that("function stops when there are wrong input arguments", {
  
  expect_error( model_fit() )
  expect_error( model_fit( chains = 4 ) )
  expect_error( model_fit( wide_data, chains ) )
  
  expect_error( get_para_sta() )
  expect_error( get_para_sta( chains = 4 ) )
  expect_error( get_para_sta( wide_data, chains ) )
  
  expect_error( get_paras_median() )
  expect_error( get_paras_median( chains = 4 ) )
  expect_error( get_paras_median( wide_data, chains ) )
  
})

test_that("model fit works for example data", {
  
  model_fit_output_example <- model_fit(wide_data, chains = 1, iter = 200)
  expect_equal( typeof(model_fit_output_example), "S4" )
  expect_match( class(model_fit_output_example), "stanfit" )
  
})

test_that("getting parameter statistical results works for example data", {
  
  para_sta_result <- get_para_sta(wide_data, chains = 1, iter = 200)
  expect_match( class(para_sta_result), "data.frame" )
  expect_equal( is.na(para_sta_result[['scaling.factor.Sup']]), FALSE )
  expect_equal( is.na(para_sta_result[['scaling.factor.Pellet']]), FALSE )
  
})

test_that("getting parameter statistical results of each condition works for example data", {
  
  paras_median_each_Condition <- get_paras_median(wide_data, chains = 1, iter = 200)
  col_names <- paste( unlist(colnames(paras_median_each_Condition)), collapse=' ')
  expect_match( col_names, "Condition" )
  
})

test_that("1 page of pr is 15 links", {
  expect_equal(nrow(get_pr_url()), 15)
})

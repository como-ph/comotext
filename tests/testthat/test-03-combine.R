x <- combine_docs("resolution")

test_that("gets resolutions only", {
  expect_equal(unique(x$type), "resolution")
})


test_that("output has 6 columns", {
  expect_equal(ncol(x), 6)
})


x <- combine_iatf(res = 9:12)

test_that("resolutions 9 to 12 are retrieved", {
  expect_equal(unique(x$id), 9:12)
})

test_that("source is iatf", {
  expect_equal(unique(x$source), "IATF")
})



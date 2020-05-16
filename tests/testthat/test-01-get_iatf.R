test_that("iatf links output is a tibble", {
  expect_is(get_iatf_links(), "tbl")
})

test_that("resolution number is numeric", {
  expect_is(get_iatf_links()$id, "numeric")
})

test_that("date is date", {
  expect_is(get_iatf_links()$date, "Date")
})

test_that("output has 4 columns", {
  expect_equal(ncol(get_iatf_links()), 4)
})

test_that("output has expected column names", {
  expect_equal(names(get_iatf_links()), c("id", "title", "date", "link"))
})


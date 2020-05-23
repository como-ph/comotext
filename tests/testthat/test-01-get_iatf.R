base <- "http://www.doh.gov.ph/COVID-19/IATF-Resolutions"

test_that("iatf links output is a tibble", {
  expect_is(get_iatf_links(base = base), "tbl")
})

test_that("resolution number is numeric", {
  expect_is(get_iatf_links(base = base)$id, "numeric")
})

test_that("date is date", {
  expect_is(get_iatf_links(base = base)$date, "Date")
})

test_that("output has 6 columns", {
  expect_equal(ncol(get_iatf_links(base = base)), 6)
})

test_that("output has expected column names", {
  expect_equal(names(get_iatf_links(base = base)), c("id", "title", "date", "source", "type", "url"))
})


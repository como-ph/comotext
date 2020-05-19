base1 <- "http://www.doh.gov.ph/press-releases"
base2 <- "http://www.doh.gov.ph"

test_that("1 page of pr is 15 links", {
  expect_equal(nrow(get_doh_links(base = base1, pages = 1)), 15)
  expect_equal(nrow(get_doh_links(base = base1, pages = 1:3)), 45)
})

test_that("output is a tibble", {
  expect_is(get_doh_links(base = base1, pages = 1), "tbl")
})


test_that("output columns is 3", {
  expect_equal(ncol(get_doh_links(base = base1, pages = 1)), 6)
})

test_that("id is numeric and date is Date", {
  expect_is(get_doh_links(base = base1, pages = 1)$id, "numeric")
  expect_is(get_doh_links(base = base1, pages = 1)$date, "Date")
})

test_that("output is a tibble", {
  expect_is(get_doh_release(df = dohLinks[3, ]), "tbl")
})

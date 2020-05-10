library(rvest)
library(stringr)
library(comotext)

## Extract press releases ######################################################

pr <- get_pr_url(pages = 1:25)

prLinks <- pr

usethis::use_data(prLinks, overwrite = TRUE, compress = "xz")

## Extract text from press releases ############################################

pressRelease <- NULL

for(i in 1:nrow(pr)) {
  currentPR <- get_press_release(df = pr)

  pressRelease <- rbind(pressRelease, currentPR)
}

usethis::use_data(pressRelease, overwrite = TRUE, compress = "xz")


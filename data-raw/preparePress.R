library(rvest)
library(stringr)
library(comotext)

## Extract press releases ######################################################

pr <- get_pr_url(pages = 1:7)

## Extract text from press releases ############################################

pressRelease <- NULL

for(i in 1:nrow(pr)) {
  ##
  currentURL <- paste("https://www.doh.gov.ph", pr$url[i], sep = "")
  currentURLdate <- pr$date[i]

  currentPR <- get_press_release(url = currentURL, date = currentURLdate)

  pressRelease <- rbind(pressRelease, currentPR)
}

usethis::use_data(pressRelease, overwrite = TRUE, compress = "xz")


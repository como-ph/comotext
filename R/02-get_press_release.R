################################################################################
#
#'
#' Extract title of press releases from Department of Health website
#'
#' @param base Base URL for press releases in the Department of Health website.
#'   Default is \url{https://www.doh.gov.ph/press-releases}
#' @param pages A vector of page numbers corresponding to the page panel
#'   containing the press release link
#' @param proxy Logical. Are you running on a network with a proxy server?
#'   Default is FALSE.
#'
#' @return A tibble of 2 columns: 1) press release title; and, 2) date of press
#'   release.
#'
#' @examples
#' get_pr_url(pages = 1, proxy = FALSE)
#'
#' @export
#'
#
################################################################################

get_pr_url <- function(base = "https://www.doh.gov.ph/press-releases",
                       pages = 1:13,
                       proxy = FALSE) {
  ## Concatenating vectors
  prURL <- NULL
  prDate <- NULL

  ## Cycle through pages
  for(i in pages) {
    wp <- paste(base, "?page=", i - 1, sep = "")
    if(i == 1) wp <- base

    if(proxy) {
      utils::download.file(url = wp, destfile = paste(tempdir(), "temp.html", sep = "/"))
      wp <- paste(tempdir(), "temp.html", sep = "/")
    }

    href <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .views-field-title .field-content a") %>%
      rvest::html_attr(name = "href")

    href <- href[stringr::str_detect(string = href, pattern = "press-release")]

    hrefDate <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .content-time") %>%
      rvest::html_text()

    hrefDate <- hrefDate[1:length(href)]

    ##
    prURL <- c(prURL, href)
    prDate <- c(prDate, hrefDate)
  }

  ##
  prDate <- lubridate::mdy(prDate)

  ##
  pr <- tibble::tibble(data.frame(url = prURL,
                                  date = prDate,
                                  stringsAsFactors = FALSE))

  ## Return DF
  return(pr)
}


################################################################################
#
#' Extract text of press release from the Philippines Department of Health
#' website
#'
#' @param url of press release to extract text from
#' @param date Date press release was issued. Should be in <YYYY-MM-DD> format.
#'
#' @return A tibble containing text of the press release with additional
#'   information on line number, type of text and date of press release.
#'
#' @examples
#' baseURL <- "https://www.doh.gov.ph"
#' prURL <- get_pr_url(pages = 1)[1, "url"]
#' get_press_release(url = paste(baseURL, prURL, sep = ""),
#'                   date = get_pr_url(pages = 1)[1, "date"])
#'
#' @export
#'
#'
#
################################################################################

get_press_release <- function(url, date) {
  ## Extract text from URL
  z <- xml2::read_html(x = url) %>%
    rvest::html_nodes(css = ".panel") %>%
    rvest::html_text() %>%
    stringr::str_split(pattern = "\n") %>%
    unlist() %>%
    stringr::str_trim(side = "both")

  ## Remove empty elements
  z <- z[z != ""]

  ## Split z to 80 characters width
  pressRelease <- stringr::str_wrap(string = z[[3]], width = 80)
  pressRelease <- stringr::str_split(string = pressRelease, pattern = "\n")

  ## Concatenate title with body of press release
  pressRelease <- c(z[[2]], pressRelease[[1]])

  ## Create pressRelease data.frame
  pressRelease <- data.frame(linenumber = 1:length(pressRelease),
                             text = pressRelease,
                             type = "press release",
                             id = NA,
                             date = date,
                             stringsAsFactors = FALSE)

  ## Convert pressRelease to tibble
  pressRelease <- tibble::tibble(pressRelease)

  ## Return pressRelease
  return(pressRelease)
}




################################################################################
#
#'
#' Extract title of press releases from Department of Health website
#'
#' @param pages A vector of page numbers corresponding to the page panel
#'   containing the press release link
#'
#' @return A tibble of 2 columns: 1) press release title; and, 2) date of press
#'   release.
#'
#' @examples
#' get_pr_title(pages = 1:5)
#'
#' @export
#'
#
################################################################################

get_pr_title <- function(pages = 1:13) {
  ## Concatenating vectors
  prTitle <- NULL
  prDate <- NULL

  ## Cycle through pages
  for(i in pages) {
    wp <- paste("https://www.doh.gov.ph/press-releases?page=", i - 1, sep = "")
    if(i == 1) wp <- "https://www.doh.gov.ph/press-releases"

    htmlText <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".panel") %>%
      rvest::html_text() %>%
      stringr::str_split(pattern = "\n") %>%
      unlist() %>%
      stringr::str_trim(side = "both")

    ##
    htmlText <- htmlText[!htmlText %in% c("", "Press Releases",
                                          "?php print render($page['highlighted']); ?>")]

    ##
    htmlText <- htmlText[1:30]

    ##
    prTitle <- c(prTitle, htmlText[seq(from = 1, to = length(htmlText), by = 2)])
    prDate <- c(prDate, htmlText[seq(from = 2, to = length(htmlText), by = 2)])
  }

  ##
  pr <- tibble::tibble(data.frame(prTitle, prDate, stringsAsFactors = FALSE))

  ## Return DF
  return(pr)
}


################################################################################
#
#' Extract text of press release from the Philippines Department of Health
#' website
#'
#' @param url of press release to extract text from
#' @param date Date press release was issued. Should be in <DD/MM/YYYY> format.
#'
#' @return A tibble containing text of the press release with additional
#'   information on line number, type of text and date of press release.
#'
#' @examples
#' baseURL <- "https://www.doh.gov.ph/press-release"
#' prTitle <- "ECQ-Buys-PH-Time-Continued-Practice-of-Healthy-Behavior-Needed-to-Sustain-Gains"
#' get_press_release(url = paste(baseURL, prTitle, sep = "/"),
#'                   date = "07/04/2020")
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
                             date = as.Date(date, format = "%d/%m/%y"),
                             stringsAsFactors = FALSE)

  ## Convert pressRelease to tibble
  pressRelease <- tibble::tibble(pressRelease)

  ## Return pressRelease
  return(pressRelease)
}




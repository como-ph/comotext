################################################################################
#
#'
#' Extract title of press releases from Department of Health website
#'
#' @param base Base URL for press releases in the Department of Health website.
#'   Default is \url{https://www.doh.gov.ph/press-releases}
#' @param pages A vector of page numbers corresponding to the page panel
#'   containing the press release link. Default is 1:25. Press releases only go
#'   up to page 25. Values higher than 25 will error.
#'
#' @return A tibble of 2 columns: 1) press release title; 2) press release
#'   unique identifier; and, 3) date of press release.
#'
#' @examples
#' ## Get press release URLs for first page of press release panel. The base
#' ## argument has been specified using non-SSL version of base URL to prevent
#' ## erroring for those with proxy server connections (i.e., in Travis tests)
#' get_pr_url(base = "http://www.doh.gov.ph/press-releases",
#'            pages = 1)
#'
#' @export
#'
#
################################################################################

get_pr_url <- function(base = "https://www.doh.gov.ph/press-releases",
                       pages = 1:25) {
  ## Check that pages goes up to 25 only
  if(max(pages) > 25) {
    stop("The current maximum pages for press releases in the DoH website
         is 25. Please try again.", call. = TRUE)
  }

  ## Concatenating vectors
  prURL <- NULL
  prID <- NULL
  prDate <- NULL

  ## Cycle through pages
  for(i in pages) {
    wp <- paste(base, "?page=", i - 1, sep = "")
    if(i == 1) wp <- base

    ## Extract and process press release relative links
    href <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .views-field-title .field-content a") %>%
      rvest::html_attr(name = "href")

    href <- stringr::str_subset(string = href, pattern = "press-release|node")
    href <- stringr::str_subset(string = href, pattern = "20343|19904", negate = TRUE)

    ## Generate unique identifiers for each press release
    id <- stringr::str_split_fixed(string = href, pattern = "/", n = 3)[ , 3]
    id <- id %>%
      stringr::str_remove_all(pattern = "-") %>%
      stringr::str_extract(pattern = "[a-zA-Z]{8}") %>%
      stringr::str_to_upper() %>%
      stringr::str_split(pattern = "", simplify = TRUE)

    id <- matrix(data = match(id, LETTERS[1:26]),
                 nrow = nrow(id),
                 ncol = 8,
                 byrow = FALSE)

    hrefID <- NULL

    for(j in 1:nrow(id)) {
      if(all(is.na(id[j, ]))) {
        hrefID <- c(hrefID,
                    stringr::str_extract(string = href[j],
                                         pattern = "[0-9]{4}|[0-9]{5}|[0-9]{6}|[0-9]{7}|[0-9]{8}"))
      } else {
        hrefID <- c(hrefID, paste(id[j, ], collapse = ""))
      }
    }

    hrefID <- stringr::str_extract(string = hrefID,
                                   pattern = "[0-9]{4}|[0-9]{5}|[0-9]{6}|[0-9]{7}|[0-9]{8}")

    ## Extract and process press release issue date
    hrefDate <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .content-time") %>%
      rvest::html_text()

    hrefDate <- hrefDate[1:length(href)]

    ## Concatenate url, id and date
    prURL <- c(prURL, href)
    prID <- c(prID, hrefID)
    prDate <- c(prDate, hrefDate)
  }

  ## Convert prDate to date format
  prDate <- lubridate::mdy(prDate)

  ## Convert prID to numeric
  prID <- as.numeric(prID)

  ## Create tibble
  pr <- tibble::tibble(data.frame(url = prURL,
                                  id = prID,
                                  date = prDate,
                                  stringsAsFactors = FALSE))

  ## Return DF
  return(pr)
}


################################################################################
#
#'
#' Extract title, URLs, unique identifiers and date of release of press releases
#' from the Department of Health website
#'
#' @param base Base URL for press releases in the Department of Health website.
#'   Default is \url{https://www.doh.gov.ph/press-releases}
#' @param pages A vector of page numbers corresponding to the page panel
#'   containing the press release link. Default is 1:25. Press releases only go
#'   up to page 25. Values higher than 25 will error.
#'
#' @return A tibble of 4 columns: 1) relative URLs of press release; 2) press
#'   release title; 3) press release unique identifier; and, 4) date of press
#'   release.
#'
#' @examples
#' ## Get press release URLs for first page of press release panel. The base
#' ## argument has been specified using non-SSL version of base URL to prevent
#' ## erroring for those with proxy server connections (i.e., in Travis tests)
#' get_doh_links(base = "http://www.doh.gov.ph/press-releases",
#'               pages = 1)
#'
#' @export
#'
#
################################################################################

get_doh_links <- function(base = "https://www.doh.gov.ph/press-releases",
                          pages = 1:25) {
  ## Check that pages goes up to 25 only
  if(max(pages) > 25) {
    stop("The current maximum pages for press releases in the DoH website
         is 25. Please try again.", call. = TRUE)
  }

  ## Concatenating vectors
  prURL <- NULL
  prID <- NULL
  prDate <- NULL

  ## Cycle through pages
  for(i in pages) {
    wp <- paste(base, "?page=", i - 1, sep = "")
    if(i == 1) wp <- base

    ## Extract and process press release relative links
    href <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .views-field-title .field-content a") %>%
      rvest::html_attr(name = "href")

    href <- stringr::str_subset(string = href, pattern = "press-release|node")
    href <- stringr::str_subset(string = href, pattern = "20343|19904", negate = TRUE)

    ## Generate unique identifiers for each press release
    id <- stringr::str_split_fixed(string = href, pattern = "/", n = 3)[ , 3]
    id <- id %>%
      stringr::str_remove_all(pattern = "-") %>%
      stringr::str_extract(pattern = "[a-zA-Z]{8}") %>%
      stringr::str_to_upper() %>%
      stringr::str_split(pattern = "", simplify = TRUE)

    id <- matrix(data = match(id, LETTERS[1:26]),
                 nrow = nrow(id),
                 ncol = 8,
                 byrow = FALSE)

    hrefID <- NULL

    for(j in 1:nrow(id)) {
      if(all(is.na(id[j, ]))) {
        hrefID <- c(hrefID,
                    stringr::str_extract(string = href[j],
                                         pattern = "[0-9]{4}|[0-9]{5}|[0-9]{6}|[0-9]{7}|[0-9]{8}"))
      } else {
        hrefID <- c(hrefID, paste(id[j, ], collapse = ""))
      }
    }

    hrefID <- stringr::str_extract(string = hrefID,
                                   pattern = "[0-9]{4}|[0-9]{5}|[0-9]{6}|[0-9]{7}|[0-9]{8}")

    ## Extract and process press release issue date
    hrefDate <- xml2::read_html(x = wp) %>%
      rvest::html_nodes(css = ".view-content .content-time") %>%
      rvest::html_text()

    hrefDate <- hrefDate[1:length(href)]

    ## Concatenate url, id and date
    prURL <- c(prURL, href)
    prID <- c(prID, hrefID)
    prDate <- c(prDate, hrefDate)
  }

  ## Convert prDate to date format
  prDate <- lubridate::mdy(prDate)

  ## Convert prID to numeric
  prID <- as.numeric(prID)

  ## Create tibble
  pr <- tibble::tibble(data.frame(url = prURL,
                                  id = prID,
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
#' @param base Base URL for press releases in the Department of Health website.
#'   Default is \url{https://www.doh.gov.ph}
#' @param df A data.frame created using \code{get_pr_url} providing values for
#'   relative URL of press release/s, unique identifier of press release and,
#'   date of issue of press release.
#'
#' @return A tibble containing text of the press release with additional
#'   information on line number, type of text, unique identifier and date of
#'   press release.
#'
#' @examples
#' prURL <- get_pr_url(base = "http://www.doh.gov.ph/press-releases",
#'                     pages = 1)
#' get_press_release(base = "http://www.doh.gov.ph",
#'                   df = prURL[1, ])
#'
#' @export
#'
#'
#
################################################################################

get_press_release <- function(base = "https://www.doh.gov.ph",
                              df) {
  ## Form URL
  url <- paste(base, df$url, sep = "")

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
                             source = "DOH",
                             type = "press release",
                             id = df$id,
                             date = df$date,
                             stringsAsFactors = FALSE)

  ## Convert pressRelease to tibble
  pressRelease <- tibble::tibble(pressRelease)

  ## Return pressRelease
  return(pressRelease)
}


################################################################################
#
#' Extract text of press release from the Philippines Department of Health
#' website
#'
#' @param base Base URL for press releases in the Department of Health website.
#'   Default is \url{https://www.doh.gov.ph}
#' @param df A data.frame created using \code{get_pr_url} providing values for
#'   relative URL of press release/s, unique identifier of press release and,
#'   date of issue of press release.
#'
#' @return A tibble containing text of the press release with additional
#'   information on line number, type of text, unique identifier and date of
#'   press release.
#'
#' @examples
#' prURL <- get_pr_url(base = "http://www.doh.gov.ph/press-releases",
#'                     pages = 1)
#' get_press_release(base = "http://www.doh.gov.ph",
#'                   df = prURL[1, ])
#'
#' @export
#'
#'
#
################################################################################

get_doh_release <- function(base = "https://www.doh.gov.ph", df) {
  ## Form URL
  url <- paste(base, df$url, sep = "")

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
                             source = "DOH",
                             type = "press release",
                             id = df$id,
                             date = df$date,
                             stringsAsFactors = FALSE)

  ## Convert pressRelease to tibble
  pressRelease <- tibble::tibble(pressRelease)

  ## Return pressRelease
  return(pressRelease)
}


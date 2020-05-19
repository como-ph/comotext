################################################################################
#
#'
#' Get URLs of Philippines Department of Foreign Affairs (DFA) press releases
#'
#' @param base Base URL for press releases in the Department of Foreign Affairs
#'   website. Default is \url{https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate}
#' @param type Type of text contained in the URLs. This can be one of the
#'   following: resolution, press release, advisory, statement, etc.
#'
#' @return A tibble containing information on title of the press release,
#'   release date of press release and the absolute URL link to press release
#'
#' @examples
#' get_dfa_links(base = "https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate",
#'               type = "press release")
#'
#' @export
#'
#
################################################################################

get_dfa_links <- function(base = "https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate",
                          type) {
  ## Get html
  xHTML <- xml2::read_html(x = base)

  ## Extract number of pages
  end <- xHTML %>%
    rvest::html_node(css = ".pagination ul .pagination-end a") %>%
    rvest::html_attr(name = "href") %>%
    stringr::str_extract(pattern = "[0-9]+")

  ## Get sequence of page numbers based on filter and ending number
  nPages <- seq(from = 10, to = as.numeric(end), by = 10)

  ## Check if last number in sequence nPages is lower or equal to end
  if(max(nPages) < end) nPages <- c(nPages, end)

  ## Title
  titleTable <- xHTML %>%
    rvest::html_nodes(css = ".table-noheader") %>%
    rvest::html_table()

  titleTable <- titleTable[[1]]

  ## URL
  urlList <- xHTML %>%
    rvest::html_nodes(css = ".table-noheader .list-title a") %>%
    rvest::html_attr(name = "href") %>%
    xml2::url_absolute(base = base)

  ## Cycle through pages
  for(i in nPages) {
    ## Get html
    yHTML <- xml2::read_html(x = paste(base, "?start=", i, sep = ""))

    ## Extract table from current set of pages
    xx <- yHTML %>%
      rvest::html_nodes(css = ".table-noheader") %>%
      rvest::html_table()

    xx <- xx[[1]]

    ## Extract url from current set of pages
    yy <- yHTML %>%
      rvest::html_nodes(css = ".table-noheader .list-title a") %>%
      rvest::html_attr(name = "href")

    ## Concatenate tables by page
    titleTable <- rbind(titleTable, xx)

    ## Concatenate URLs by page
    urlList <- c(urlList, yy)
  }

  ## Extract id from URLs
  id <- stringr::str_extract(string = urlList, pattern = "[0-9]+")

  ## Concatenate titles with urls
  urlTable <- data.frame(id,
                         titleTable,
                         "DFA",
                         type,
                         urlList,
                         stringsAsFactors = FALSE)

  ## Rename table
  names(urlTable) <- c("id", "title", "date", "source", "type", "url")

  ## date to Date format
  urlTable$date <- lubridate::dmy(urlTable$date)

  ## Convert to tibble
  urlTable <- tibble::tibble(urlTable)

  ## Retrun linksTable
  return(urlTable)
}



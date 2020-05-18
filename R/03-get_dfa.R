################################################################################
#
#'
#' Get URLs of Philippines Department of Foreign Affairs (DFA) press releases
#'
#' @param base Base URL for press releases in the Department of Foreign Affairs
#'   website. Default is \url{https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate}
#'
#' @return A tibble containing information on title of the press release,
#'   release date of press release and the absolute URL link to press release
#'
#' @examples
#' get_dfa_links(base = "http://www.dfa.gov.ph/dfa-news/dfa-releasesupdate")
#'
#' @export
#'
#
################################################################################

get_dfa_links <- function(base = "https://www.dfa.gov.ph/dfa-news/dfa-releasesupdate") {
  ## Extract number of pages
  end <- xml2::read_html(x = base) %>%
    rvest::html_node(css = ".pagination ul .pagination-end a") %>%
    rvest::html_attr(name = "href") %>%
    stringr::str_extract(pattern = "[0-9]+")

  ## Get sequence of page numbers based on filter and ending number
  nPages <- seq(from = 10, to = as.numeric(end), by = 10)

  ## Check if last number in sequence nPages is lower or equal to end
  if(max(nPages) < end) nPages <- c(nPages, end)

  ## Get html
  xHTML <- xml2::read_html(x = base)

  ##
  titleTable <- xHTML %>%
    rvest::html_nodes(css = ".table-noheader") %>%
    rvest::html_table()

  titleTable <- titleTable[[1]]

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

  ## Concatenate titles with urls
  urlTable <- data.frame(titleTable, urlList, stringsAsFactors = FALSE)

  ## Rename table
  names(urlTable) <- c("title", "date", "url")

  ## Convert to tibble
  titleTable <- tibble::tibble(urlTable)

  ## Retrun linksTable
  return(urlTable)
}



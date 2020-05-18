################################################################################
#
#'
#'
#'
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
  if(max(nPages < end)) nPages <- c(nPages, end)

  ##
  titleTable <- xml2::read_html(x = base) %>%
    rvest::html_node(css = ".table-noheader") %>%
    rvest::html_table()

  ## Cycle through pages
  for(i in nPages) {
    ## Extract table from current set of pages
    xx <- xml2::read_html(x = paste(base, "?start=", i, sep= "")) %>%
      rvest::html_node(css = ".table-noheader") %>%
      rvest::html_table()

    ## Concatenate tables by page
    titleTable <- rbind(titleTable, xx)
  }

  ## Convert to tibble
  titleTable <- tibble::tibble(titleTable)

  ## Retrun linksTable
  return(titleTable)
}

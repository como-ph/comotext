################################################################################
#
#'
#' Get list of links to IATF resolutions
#'
#' @param base URL to the IATF resolutions webpage
#'
#' @return A tibble of links to all the current IATF resolutions
#'
#' @examples
#' get_iatf_links(base = "http://www.doh.gov.ph/COVID-19/IATF-Resolutions")
#'
#' @export
#'
#
################################################################################

get_iatf_links <- function(base = "https://www.doh.gov.ph/COVID-19/IATF-Resolutions") {
  ## Get page table
  xx <- xml2::read_html(base) %>%
    rvest::html_nodes(css = ".panel .view-content .views-table") %>%
    rvest::html_table()

  ## Convert Resolution No. to numeric
  xx[[1]]$`Resolution No.` <- as.numeric(xx[[1]]$`Resolution No.`)

  ## Convert date to date class with format YYYY-MM-DD
  xx[[1]]$Date <- lubridate::mdy(xx[[1]]$Date)

  ## Get href links per resolution
  yy <- xml2::read_html(base) %>%
    rvest::html_nodes(css = ".panel .view-content .views-field a") %>%
    rvest::html_attr(name = "href")

  ## Extract Resolution number from links
  id <- stringr::str_remove_all(string = yy, pattern = "%20")
  id <- stringr::str_extract(string = id, pattern = "[0-9]+")

  ## Add links id to links
  yy <- data.frame(id, link = yy, stringsAsFactors = FALSE)

  ## Merge links with page table
  linkTable <- merge(xx[[1]], yy, by.x = "Resolution No.", by.y = "id")
  names(linkTable) <- c("id", "title", "date", "link")

  ## Convert to tibble
  linkTable <- tibble::tibble(linkTable)

  ## Return
  return(linkTable)
}


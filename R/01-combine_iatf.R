################################################################################
#
#' Combine specific documents available in the comotext package into a single
#' dataset
#'
#' @param docs A vector of terms to search for in the document names
#'
#' @return A tibble of all document types called for.
#'
#' @examples
#' combine_docs(docs = "resolution")
#'
#' @export
#'
#
################################################################################

combine_docs <- function(docs = c("resolution")) {
  ## Get multiple variations of search term
  x <- c(docs, stringr::str_to_title(string = docs))

  ## Check whether dataset names in comotext matches search term
  y <- stringr::str_detect(string = utils::data(package = "comotext")$results[ , "Item"],
                           pattern = paste(x, collapse = "|"))

  ## Retrieve dataset names matching search terms
  z <- utils::data(package = "comotext")$results[ , "Item"][y]

  ## Create concatenating data.frame
  allDocs <- data.frame()

  ## Cycle through dataset names matching search term
  for(i in z) {
    allDocs <- rbind(allDocs, eval(parse(text = z)))
  }

  allDocs <- tibble::tibble(allDocs)

  ## Return allDocs
  return(allDocs)
}


################################################################################
#
#' Combine all Inter-Agency Task Force for the management of emerging
#' infectious diseases (IATF) resolutions datasets into a single dataset
#'
#' @param docs A vector of terms to search for in the document names
#' @param res A vector of document identifiers to concatenate. Default is 9:19.
#'
#' @return A tibble of all the IATF resolutions
#'
#' @examples
#' combine_iatf()
#'
#' @export
#'
#
################################################################################

combine_iatf <- function(docs = "iatfResolution",
                         res = 9:19) {
  ##
  x <- ifelse(res < 10, paste("0", res, sep = ""), res)

  ## Extract required docs
  allRes <- combine_docs(docs = paste(docs, x, sep = ""))

  ## Return allRes
  return(allRes)
}

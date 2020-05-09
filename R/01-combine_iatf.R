################################################################################
#
#' Combine all Inter-Agency Task Force for the management of emerging
#' infectious diseases (IATF) resolutions datasets into a single dataset
#'
#' @param res A vector of resolution numbers to concatenate. Default is 9:19.
#'
#' @return A tibble of all the IATF resolutions
#'
#' @examples
#' combine_iatf()
#'
#' @source \url{https://www.doh.gov.ph/COVID-19/IATF-Resolutions}
#'
#' @export
#'
#
################################################################################

combine_iatf <- function(res = 9:19) {
  ## Create concatenating data.frame
  allRes <- data.frame()

  ## Cylce through resolutions
  for(i in res) {
    ## Get IATF Resolution name
    x <- ifelse(i < 10, paste("iatfResolution0", i, sep = ""),
                paste("iatfResolution", i, sep = ""))

    ## Get current resolution
    allRes <- rbind(allRes, eval(parse(text = x)))
  }

  ## Return allRes
  return(allRes)
}

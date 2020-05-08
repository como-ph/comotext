library(rvest)
library(pdftools)
library(stringr)

################################# Resolution 9 #################################

## Read resolution
x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-9.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

## Clean-up

y <- y[3:length(y)]
y <- y[c(1:44, 56:length(y))]

y[67] <- "FRANCISCO T. DUQUE III"
y[68] <- "Secretary, Department of Health"
y[69] <- ""
y[70] <- "EDUARDO M. AÑO"
y[71] <- "Secretary, Department of the Interior and Local Government"
y[72] <- ""
y[73] <- "BERNADETTE ROMULO-PUYAT"
y[74] <- "Secretary, Department of Tourism"
y[75] <- ""
y[76] <- "BRIGIDO J. DULAY"
y[77] <- "Undersecretary, Department of Foreign Affairs"

y <- y[c(1:78, 92:length(y))]

y[79] <- "MANUEL ANTONIO L. TAMAYO"
y[80] <- "Undersecretary, Department of Transportation"
y[81] <- ""
y[84] <- ""
y[85] <- "ALAN A. SILOR"
y[86] <- "Assistant Secretary, Department of Information and Communications Technology"
y[87] <- ""
y[88] <- "MA. TERESITA S. CUCUECO"
y[90] <- ""

y <- y[1:90]

y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y)

iatfResolution09 <- tibble::tibble(y)

usethis::use_data(iatfResolution09, overwrite = TRUE, compress = "xz")

################################# Resolution 10 ################################

## Read resolution
x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-10.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[6:length(y)]
y[41] <- stringr::str_remove(string = y[41], pattern = " J")

y <- y[c(1:42, 47:length(y))]
y <- y[c(1:82, 86:length(y))]

y <- c(y[1:85], "", y[86:length(y)])

y[87] <- "FRANCISCO T. DUQUE III"

y[89] <- ""

y[90] <- "TEODORO L. LOCSIN, JR"
y[91] <- "Secretary, Department of Foreign Affairs"

y[92] <- ""

y[93] <- "EDUARDO M. AÑO"
y[94] <- "Secretary, Department of the Interior and Local Government"

y[95] <- ""

y[96] <- y[97]
y[97] <- y[98]

y[98] <- ""

y[99]  <- "BERNADETTE FATIMA T. ROMULO-PUYAT"
y[100] <- "Secretary, Department of Tourism"

y[101] <- ""

y[102] <- "ARTHUR P. TUGADE"
y[103] <- "Secretary, Department of Transportation"

y[104] <- ""

y[105] <- "SILVESTRE H. BELLO III"
y[106] <- "Secretary, Department of Labor and Employment"

y[107] <- ""

y[108] <- "ALAN A. SILOR"
y[109] <- "Assistant Secretary, Department of Information and Communications Technology"

y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y)

iatfResolution10 <- tibble::tibble(y)

usethis::use_data(iatfResolution10, overwrite = TRUE, compress = "xz")

################################# Resolution 11 ################################

#textFile <- "https://www.doh.gov.ph/sites/default/files/health-update/IATF-RESO-11.pdf"

#download.file(url = textFile, destfile = paste(tempdir(), "/resolution.pdf", sep = ""))

#x <- pdf_text(pdf = paste(tempdir(), "/resolution.pdf", sep = ""))

x <- pdf_text(pdf = "data-raw/IATF/IATF-RESO-11.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(1:32, 41:66, 75:101, 110:138, 147:161, 170:177)]

y <- data.frame(linenumber = 1:length(y),
                text = y)

iatfResolution11 <- tibble::tibble(y)

usethis::use_data(iatfResolution11, overwrite = TRUE, compress = "xz")

################################# Resolution 12 ################################

#textFile <- "https://www.doh.gov.ph/sites/default/files/health-update/IATF-RESO-12.pdf"

#download.file(url = textFile, destfile = paste(tempdir(), "/resolution.pdf", sep = ""))

#x <- pdf_text(pdf = paste(tempdir(), "/resolution.pdf", sep = ""))

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-12.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(8:45, 57:89, 103:127, 143:174, 191:227)]

y[132] <- stringr::str_remove(string = y[132], pattern = " |")
y[133] <- "Malacañang Palace, Manila."
y[134] <- ""
y[135] <- "FRANCISCO T. DUQUE"
y[136] <- "Secretary, Department of Health"
y[137] <- ""
y[138] <- "EDUARDO M. AÑO"
y[139] <- "Secretary, Department of the Interior and Local Government"
y[140] <- ""
y[141] <- "BERNADETTE ROMULO-PUYAT"

y <- y[c(1:144, 156:165)]

y[151] <- ""
y[152] <- "ALAN A. SILOR"
y[153] <- "Assistant Secretary, Department of Information and Communications Technology"

y <- y[c(1:9, 11:13, 15, 17:22, 24:32, 34:42, 44:48, 50:51, 53:60, 62:99,
         101:107, 109:111, 113:118, 120:133, 135:136, 138:139, 141:150, 152:153)]

y[65] <- stringr::str_remove(string = y[65], pattern = " \\|")
y[84] <- stringr::str_remove(string = y[84], pattern = " \\|")
y[119] <- stringr::str_remove(string = y[119], pattern = " \\|")

y <- data.frame(linenumber = 1:length(y),
                text = y)

iatfResolution12 <- tibble::tibble(y)

usethis::use_data(iatfResolution12, overwrite = TRUE, compress = "xz")

################################# Resolution 13 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-13.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))


################################# Resolution 14 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-14.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))


################################# Resolution 15 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-15.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

################################# Resolution 16 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-16.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

################################# Resolution 17 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF Resolution No. 17.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

################################# Resolution 18 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-18.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

################################# Resolution 19 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF Resolution No. 19.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

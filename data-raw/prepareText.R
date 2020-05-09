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
                text = y,
                resolution = 9,
                date = as.Date("03/03/2020", format = "%d/%m/%y"))

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
                text = y,
                resolution = 10,
                date = as.Date("09/03/2020", format = "%d/%m/%y"))

iatfResolution10 <- tibble::tibble(y)

usethis::use_data(iatfResolution10, overwrite = TRUE, compress = "xz")

################################# Resolution 11 ################################

x <- pdf_text(pdf = "data-raw/IATF/IATF-RESO-11.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(1:32, 41:66, 75:101, 110:138, 147:161, 170:177)]

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 11,
                date = as.Date("12/03/2020", format = "%d/%m/%y"))

iatfResolution11 <- tibble::tibble(y)

usethis::use_data(iatfResolution11, overwrite = TRUE, compress = "xz")

################################# Resolution 12 ################################

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
                text = y,
                resolution = 12,
                date = as.Date("13/03/2020", format = "%d/%m/%y"))

iatfResolution12 <- tibble::tibble(y)

usethis::use_data(iatfResolution12, overwrite = TRUE, compress = "xz")

################################# Resolution 13 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-13.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(7:38, 46:59, 61:63, 65:81, 91:134, 143:175, 184:length(y))]

y[166] <- "FRANCISCO T DUQUE III"
y[167] <- "Secretary, Department of Health"
y[168] <- "EDUARDO M. AÑO"
y[169] <- "Secretary, Department of Interior and Local Government"
y[170] <- "BERNADETTE ROMULO-PUYAT"
y[171] <- "Secretary, Department of Tourism"
y[172] <- "SILVESTRE H. BELLO III"
y[173] <- "Secretary, Department of Labor and Employment"
y[174] <- "MENARDO I. GUEVARRA"
y[175] <- "Secretary, Department of Justice"
y[176] <- "BRIGIDO J. DULAY"
y[177] <- "Undersecretary, Department of Foreign Affairs"
y[178] <- "ARTEMIO U. TUAZON, JR."
y[179] <- "ALAN A. SILOR"
y[180] <- "Assistant Secretary, Department of Information and Communications Technology"
y[181] <- "With the concurrence of:"
y[182] <- "KARLO B. NOGRALES"
y[183] <- "Cabinet Secretary, Cabinet Secretariat of the Philippines"
y[184] <- "RAMON M. LOPEZ"
y[185] <- y[210]
y[186] <- "ROLANDO JOSELITO D. BAUTISTA"
y[187] <- y[213]
y[188] <- y[214]
y[189] <- y[215]
y[190:193] <- y[216:219]
y[194] <- "MARTIN M. ANDANAR"
y[195] <- "Secretary, Presidential Communications Operations Office"
y[196:197] <- y[222:223]
y[198] <- "RICARDO B. JALAD"
y[199] <- "Administrator, Office of the Civil Defense"
y[200:203] <- y[234:237]
y[204] <- "RONNIE GIL L. GAVAN"
y[205] <- "Acting Deputy Chief of Staff for Operations, Philippine Coast Guard"
y[206] <- "VICENTE M. AGDAMAG"
y[207] <- y[242]
y[208] <- "JESUS L. R. MATEO"
y[209] <- "Undersecretary, Department of Education"
y[210] <- "BAYANI H. AGABIN"
y[211] <- y[247]
y[212] <- y[249]
y[213] <- "Undersecretary, National Economic and Development Authority"
y[214] <- y[251]
y[215] <- "Assistant Secretary, Office of the Chief Presidential Legal Counsel"

y <- y[1:215]
y <- y[y != ""]
y[14] <- stringr::str_remove(string = y[14], pattern = ": ")
y[14] <- stringr::str_remove(string = y[14], pattern = ":")
y[15] <- stringr::str_remove(string = y[15], pattern = "z ")
y[16] <- stringr::str_remove(string = y[16], pattern = "3 ")
y[45] <- stringr::str_remove(string = y[45], pattern = ": ")
y[46] <- stringr::str_remove(string = y[46], pattern = "4 ")
y[46] <- stringr::str_remove(string = y[46], pattern = ":")
y[47] <- stringr::str_remove(string = y[47], pattern = "; ")
y[52] <- stringr::str_remove(string = y[52], pattern = "\\? ")
y[53] <- stringr::str_remove(string = y[53], pattern = "\\| ")
y[54] <- stringr::str_remove(string = y[54], pattern = "\\| ")
y[55] <- stringr::str_remove(string = y[55], pattern = "\\| ")
y[56] <- stringr::str_remove(string = y[56], pattern = "\\| ")
y[57] <- stringr::str_remove(string = y[57], pattern = "\\| ")
y[75] <- stringr::str_replace(string = y[75], pattern = "OF Ws", replacement = "OFWs")
y[83] <- stringr::str_remove(string = y[83], pattern = "Z ")
y[84] <- stringr::str_remove(string = y[84], pattern = "j ")
y[86] <- stringr::str_remove(string = y[86], pattern = "f ")
y[87] <- stringr::str_remove(string = y[87], pattern = "5 ")
y[88] <- stringr::str_remove(string = y[88], pattern = "4")
y[89] <- stringr::str_remove(string = y[89], pattern = "2 ")
y[90] <- stringr::str_remove(string = y[90], pattern = "5 ")
y[91] <- stringr::str_remove(string = y[91], pattern = "& ")
y[92] <- stringr::str_remove(string = y[92], pattern = "é ")
y[115] <- stringr::str_remove(string = y[115], pattern = ": ")
y[119] <- stringr::str_remove(string = y[119], pattern = "- ")
y[121] <- stringr::str_remove(string = y[121], pattern = "z ")
y[122] <- stringr::str_remove(string = y[122], pattern = "\\% ")
y[145] <- stringr::str_remove(string = y[145], pattern = "2 ")
y[146] <- stringr::str_remove(string = y[146], pattern = "é ")
y[147] <- stringr::str_remove(string = y[147], pattern = "5 ")
y[148] <- stringr::str_remove(string = y[148], pattern = "2 ")
y[149] <- stringr::str_remove(string = y[149], pattern = "\\| ")
y[152] <- stringr::str_remove(string = y[152], pattern = "2 ")
y[120] <- stringr::str_remove(string = y[120], pattern = "= ")

y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 13,
                date = as.Date("17/03/2020", format = "%d/%m/%y"))

iatfResolution13 <- tibble::tibble(y)

usethis::use_data(iatfResolution13, overwrite = TRUE, compress = "xz")

################################# Resolution 14 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-14.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[y != ""]

y <- y[c(5:34, 36:69, 71:107, 109:146, 148:186, 188:length(y))]

y[182] <- stringr::str_replace(string = y[182], pattern = "so p", replacement = "Club House, Camp")
y[183] <- "EDUARDO M. AÑO"
y[184] <- "Secretary, Department of the Interior and Local Government"
y[185] <- "BERNADETTE ROMULO-PUYAT"
y[186] <- "Secretary, Department of Tourism"
y[187] <- "SILVESTRE H. BELLO III"
y[188] <- "Secretary, Department of Labor and Employment"
y[189] <- "GREGORIO B. HONASAN II"
y[190] <- "Secretary, Department of Information and Communications Technology"
y[191] <- y[194]
y[192] <- y[195]
y[193] <- "DEO L. MARCO"
y[194] <- "Undersecretary, Department of Justice"
y[195] <- "BRIGIDO D. DULAY"
y[196] <- "Undersecretary, Department of Foreign Affairs"
y[197:198] <- y[200:201]
y[199] <- y[203]
y[200] <- "KARLO ALEXEI B. NOGRALES"
y[201] <- y[205]
y[202:203] <- y[206:207]
y[204] <- "RAMON M. LOPEZ"
y[205] <- y[209]
y[206] <- "ROLANDO D. BAUTISTA"
y[207] <- y[211]
y[208:209] <- y[215:216]
y[210] <- "ROY A. CIMATU"
y[211] <- y[219]
y[212:213] <- y[220:221]
y[214] <- "RICARDO B. JALAD"
y[215] <- y[224]
y[216] <- stringr::str_remove(string = y[228], pattern = " \\|")
y[217] <- stringr::str_remove(string = y[229], pattern = " \\|")

y <- y[c(1:217, 230:243)]

y[218] <- stringr::str_remove(string = y[218], pattern = " :")
y[219] <- stringr::str_remove(string = y[219], pattern = " \\|")
y[220] <- stringr::str_remove(string = y[220], pattern = " \\|")
y[221] <- stringr::str_remove(string = y[221], pattern = " \\|")
y[222] <- stringr::str_remove(string = y[222], pattern = " :")
y[223] <- stringr::str_remove(string = y[223], pattern = " oe")
y[224] <- stringr::str_remove(string = y[224], pattern = " \\|")
y[225] <- stringr::str_remove(string = y[225], pattern = " :")
y[226] <- stringr::str_remove(string = y[226], pattern = " ,")
y[227] <- stringr::str_remove(string = y[227], pattern = " \\|")
y[228] <- stringr::str_remove(string = y[228], pattern = " \\|")
y[229] <- stringr::str_remove(string = y[229], pattern = " 2")
y[230] <- stringr::str_remove(string = y[230], pattern = " !")
y[231] <- stringr::str_remove(string = y[231], pattern = " 4")

y[144] <- stringr::str_remove(string = y[144], pattern = "\\| ")
y[68] <- stringr::str_remove(string = y[68], pattern = ". ")
y[73] <- stringr::str_remove(string = y[73], pattern = ". ")
y[124] <- stringr::str_replace(string = y[124], pattern = "ui.", replacement = "iii.")

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 14,
                date = as.Date("20/03/2020", format = "%d/%m/%y"))

iatfResolution14 <- tibble::tibble(y)

usethis::use_data(iatfResolution14, overwrite = TRUE, compress = "xz")

################################# Resolution 15 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-15.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- stringr::str_remove_all(string = y, pattern = "\\| |\\||= |\\/ |\\|!|\\)")
y <- y[y != ""]

y <- y[c(6:34, 43:69, 76:104, 113:123, 125:133, 135:142, 151:181, 191:208, 211:214)]

y[97] <- stringr::str_replace(string = y[97], pattern = "].", replacement = "1.")
y[132] <- stringr::str_remove(string = y[150], pattern = "1 ")
y[150] <- stringr::str_remove(string = y[150], pattern = "! ")

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 15,
                date = as.Date("25/03/2020", format = "%d/%m/%y"))

iatfResolution15 <- tibble::tibble(y)

usethis::use_data(iatfResolution15, overwrite = TRUE, compress = "xz")

################################# Resolution 16 ################################

x <- pdf_text(pdf = "data-raw/IATF/IATF-RESO-16.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 16,
                date = as.Date("30/03/2020", format = "%d/%m/%y"))

iatfResolution16 <- tibble::tibble(y)

usethis::use_data(iatfResolution16, overwrite = TRUE, compress = "xz")

################################# Resolution 17 ################################

x <- pdf_text(pdf = "data-raw/IATF/IATF Resolution No. 17.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(1:70, 74:75, 77:101, 104:119, 121, 124:139, 142:157, 160:165)]

y <- y[y != ""]

y[112] <- "SALVADOR C. MEDIALDEA"

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 17,
                date = as.Date("30/03/2020", format = "%d/%m/%y"))

iatfResolution17 <- tibble::tibble(y)

usethis::use_data(iatfResolution17, overwrite = TRUE, compress = "xz")

################################# Resolution 18 ################################

x <- pdf_ocr_text(pdf = "data-raw/IATF/IATF-RESO-18.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(1:44, 51:91, 97:137)]
y <- y[y != ""]

y[1] <- "REPUBLIC OF THE PHILIPPINES"
y[2] <- "INTER-AGENCY TASK FORCE"
y[3] <- "FOR THE MANAGEMENT OF EMERGING INFECTIOUS DISEASE"
y[4] <- ""

y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 18,
                date = as.Date("01/04/2020", format = "%d/%m/%y"))

iatfResolution18 <- tibble::tibble(y)

usethis::use_data(iatfResolution18, overwrite = TRUE, compress = "xz")

################################# Resolution 19 ################################

x <- pdf_text(pdf = "data-raw/IATF/IATF Resolution No. 19.pdf")

## Restructure text
y <- unlist(stringr::str_split(string = x, pattern = "\n"))

y <- y[c(1:35, 41:70, 76:108, 114:129, 135:149, 155:169, 175:188)]

y[140] <- "RYAN ALVIN R. ACOSTA"

y[141] <- ""
y <- y[y != ""]

y <- data.frame(linenumber = 1:length(y),
                text = y,
                resolution = 19,
                date = as.Date("03/04/2020", format = "%d/%m/%y"))

iatfResolution19 <- tibble::tibble(y)

usethis::use_data(iatfResolution19, overwrite = TRUE, compress = "xz")


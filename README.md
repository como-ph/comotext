
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comotext: R Tools to Extract COVID-19-Related Resolutions and Policies in the Philippines <img src="man/figures/comotext.png" width = "200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/como-ph/comotext.svg?branch=master)](https://travis-ci.org/como-ph/comotext)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/como-ph/comotext?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comotext)
<!-- badges: end -->

To assess possible impact of various COVID-19 prediction models on
Philippine government response, text from various resolutions, press
releases and legislation has been collected using data mining approaches
implemented in R. This package includes functions used for this data
mining process and datasets of text that have been collected and
processed for use in text analysis.

## Installation

`comotext` is still in active development. You can install the
development version of `comotext` from
[GitHub](https://github.com/como-ph/comotext) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/comotext")
```

## Usage

### Datasets

`comotext` currently has 11 datasets of COVID-19-related resolutions and
policies in the Philippines. These datasets are 11 resolutions made by
the Inter-Agency Task Force for the Management of Emerging Infectious
Diseases (IATF).

A description of the available datesets can be found
[here](https://como-ph.github.io/comotext/reference/index.html#section-datasets).

`comotext` also now holds 1 dataset of [Department of
Health](http://www.doh.gov.ph) press releases dating from December 2019
to May 2020. A description of the `pressRelease` dataset can be found
[here](https://como-ph.github.io/comotext/reference/pressRelease.html).
This dataset has been generated using the `get_press_release()` (see
description below) function included in `comotext`. If a much longer
period of press release text data is required, `get_press_release()`
function can be used to extend the period.

### Extracting text data from press releases

Press releases issued by the [Department of
Health](https://www.doh.gov.ph) are available publicly via their
[website](https://www.doh.gov.ph/press-releases). The structure of the
press releases page is that the section with the links to the press
releases text is in a panel within the web page with the panel itself
having pagination with each page containing links to 15 press releases
with press releases ordered in reverse chronological order.

The function `get_pr_url` extracts the relative URL links to each of the
press releases on a current page within the press releases panel. If we
want to get the relative URL links for the press releases on page 1 of
the press releases panel, we use:

``` r
get_pr_url(pages = 1)
#> # A tibble: 15 x 2
#>    url                                                                date      
#>    <chr>                                                              <date>    
#>  1 /press-release/ECQ-Buys-PH-Time-Continued-Practice-of-Healthy-Beh… 2020-05-09
#>  2 /press-release/biggest-mega-swabbing-center-in-moa-arena-to-open-… 2020-05-08
#>  3 /doh-press-release/Press%20Release/DUQUE-THANKS-NAVY-FRONTLINERS-… 2020-05-07
#>  4 /doh-press-release/PH-GOV%E2%80%99T-RECEIVES-7-METRIC-TONS-OF-PPE… 2020-05-07
#>  5 /doh-press-release/BEYOND-NUMBERS%3A-WHAT-THE-FLATTENING-CURVE-RE… 2020-05-07
#>  6 /doh-press-release/2ND-MEGA-SWABBING-CENTER-SET-TO-OPERATE%3B-DOH… 2020-05-06
#>  7 /doh-press-release/NEW-MEGA-SWABBING-CENTER-TO-RAMP-UP-COVID-19-T… 2020-05-06
#>  8 /doh-press-release/DOH%3A-NO-NEW-CASES-IN-41-PROVINCES%3B-PAST-TW… 2020-05-06
#>  9 /doh-press-release/PH-STARTS-TO-FLATTEN-CURVE%3B-ECQ%2C-PHYSICAL-… 2020-05-06
#> 10 /doh-press-release/DOH-LAUNCHES-MOBILE-PHONE-SURVEY-PART-2-ON-NCDs 2020-05-05
#> 11 /doh-press-release/LGUs%2C-DOH-RAMP-UP-TESTING-CAPACITY%3B-MORE-M… 2020-05-05
#> 12 /doh-press-release/DOH-VISITS-STA.ANA-HOSPITAL%2C-SOON-TO-BE-A-LE… 2020-05-04
#> 13 /doh-press-release/DOH%2C-OTHER-AGENCIES-WORK-TO-PREVENT-COVID-19… 2020-05-04
#> 14 /doh-press-release/doh-commends-osmaks-effective-infection-contro… 2020-04-30
#> 15 /doh-press-release/Duque-enlists-governors-in-5-point-%23BEATCOVI… 2020-04-30
```

The function `get_press_releases` creates a dataset of text of press
releases given a URL of a specific press release text and the date of
release. This information is provided for by `get_pr_url`. If we want to
get the text data of the press releases from page 1 of the press release
panel, we use:

``` r
##
baseURL <- "https://www.doh.gov.ph"

##
prURL <- get_pr_url(pages = 1)

##
get_press_release(url = paste(baseURL, prURL$url[1], sep = ""), 
                  date = prURL$date[1])
#> # A tibble: 57 x 5
#>    linenumber text                                     type     id    date      
#>         <int> <chr>                                    <chr>    <lgl> <date>    
#>  1          1 ECQ Buys PH Time; Continued Practice of… press r… NA    2020-05-09
#>  2          2 Press Release/07 May 2020 The Philippin… press r… NA    2020-05-09
#>  3          3 how many people test positive for COVID… press r… NA    2020-05-09
#>  4          4 which meets the benchmark set by the Wo… press r… NA    2020-05-09
#>  5          5 media forum, Health Undersecretary Dr. … press r… NA    2020-05-09
#>  6          6 the welcome news with Dr. Edsel Salvana… press r… NA    2020-05-09
#>  7          7 the Technical Advisory Group that advis… press r… NA    2020-05-09
#>  8          8 Inter-Agency Task Force (IATF). Conside… press r… NA    2020-05-09
#>  9          9 up its testing capacity, and that the s… press r… NA    2020-05-09
#> 10         10 individuals, the low positivity rate ha… press r… NA    2020-05-09
#> # … with 47 more rows
```

### Concatenating text datasets

The datasets described above can be processed and analysed on their own
or as a combined corpus of text data. `comotext` provides convenience
functions that concatenates all or specific text datasets available from
the `comotext` package.

#### Concatenating datasets based on a specific search term

The `combine_docs` function allows the user to specify search terms to
use in identifying datasets provided by the `comotext` package. The
`docs` argument allows the specification of a vector of search terms to
use to identify the names of datasets to concatenate. If the name/s of
the datasets contain these search terms, the datasets with these name/s
will be returned.

``` r
combine_docs(docs = "resolution")
#> # A tibble: 1,727 x 5
#>    linenumber text                                      type       id date      
#>         <int> <chr>                                     <chr>   <dbl> <date>    
#>  1          1 "                                    ​RE…  resolu…    19 2020-04-03
#>  2          2 "                                ​INTER-…  resolu…    19 2020-04-03
#>  3          3 "                      FOR THE MANAGEMEN… resolu…    19 2020-04-03
#>  4          4 "                                       … resolu…    19 2020-04-03
#>  5          5 "                                       … resolu…    19 2020-04-03
#>  6          6 "                                       … resolu…    19 2020-04-03
#>  7          7 "        RECOMMENDATIONS RELATIVE TO THE… resolu…    19 2020-04-03
#>  8          8 "     OF THE CORONAVIRUS DISEASE 2019 (C… resolu…    19 2020-04-03
#>  9          9 "        WHEREAS, ​on March 8, 2020, rec…  resolu…    19 2020-04-03
#> 10         10 "mobilization of a whole-of-government r… resolu…    19 2020-04-03
#> # … with 1,717 more rows
```

The `combine_iatf` function is a specialised wrapper of the
`combine_docs` function that specifically returns datasets containing
IATF resolutions. An additional argument `res` allows users to specify
which IATF resolutions to return. To get IATF resolution 10, 11, and 12,
the following call to `combine_iatf` is made as follows:

``` r
combine_iatf(docs = "resolution", res = 10:12)
#> # A tibble: 408 x 5
#>    linenumber text                                      type       id date      
#>         <int> <chr>                                     <chr>   <dbl> <date>    
#>  1          1 REPUBLIC OF THE PHILIPPINES               resolu…    12 2020-03-13
#>  2          2 DOH - DFA - DILG - DOJ - DOLE - DOT - DO… resolu…    12 2020-03-13
#>  3          3 INTER-AGENCY TASK FORCE FOR THE MANAGEME… resolu…    12 2020-03-13
#>  4          4 EMERGING INFECTIOUS DISEASE               resolu…    12 2020-03-13
#>  5          5 RESOLUTION NO. 12                         resolu…    12 2020-03-13
#>  6          6 Series of 2020                            resolu…    12 2020-03-13
#>  7          7 March 13, 2020                            resolu…    12 2020-03-13
#>  8          8 RECOMMENDATIONS FOR THE MANAGEMENT        resolu…    12 2020-03-13
#>  9          9 OF THE CORONAVIRUS DISEASE 2019 (COVID-1… resolu…    12 2020-03-13
#> 10         10 WHEREAS, on March 12, 2020, the IATF wit… resolu…    12 2020-03-13
#> # … with 398 more rows
```

To check if only resolutions 10 to 12 have been returned:

``` r
combine_iatf(docs = "resolution", res = 10:12)[ , c("type", "id")]
#> # A tibble: 408 x 2
#>    type          id
#>    <chr>      <dbl>
#>  1 resolution    12
#>  2 resolution    12
#>  3 resolution    12
#>  4 resolution    12
#>  5 resolution    12
#>  6 resolution    12
#>  7 resolution    12
#>  8 resolution    12
#>  9 resolution    12
#> 10 resolution    12
#> # … with 398 more rows
```

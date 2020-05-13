
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comotext: R Tools to Extract COVID-19-Related Resolutions and Policies in the Philippines <img src="man/figures/comotext.png" width = "200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
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

`comotext` currently has 24 datasets of COVID-19-related resolutions and
policies in the Philippines. These datasets are 24 resolutions made by
the Inter-Agency Task Force for the Management of Emerging Infectious
Diseases (IATF).

A description of the available datasets can be found
[here](https://como-ph.github.io/comotext/reference/index.html#section-datasets).

A table of the 24 IATF resolutions and the URLs to download them can be
generated using the function `get_iatf_links()` as follows:

``` r
get_iatf_links()
#> # A tibble: 25 x 4
#>       id title                          date       link                         
#>    <dbl> <chr>                          <date>     <chr>                        
#>  1     9 Recommendations for the Manag… 2020-03-03 https://doh.gov.ph/sites/def…
#>  2    10 Recommendations for the Manag… 2020-03-09 https://doh.gov.ph/sites/def…
#>  3    11 Recommendations for the Manag… 2020-03-12 https://doh.gov.ph/sites/def…
#>  4    12 Recommendations for the Manag… 2020-03-13 https://doh.gov.ph/sites/def…
#>  5    13 Recommendations for the Manag… 2020-03-17 https://doh.gov.ph/sites/def…
#>  6    14 Resolutions Relative to the M… 2020-03-20 https://doh.gov.ph/sites/def…
#>  7    15 Resolutions Relative to the M… 2020-03-25 https://doh.gov.ph/sites/def…
#>  8    16 Additional Guidelines for the… 2020-03-30 https://doh.gov.ph/sites/def…
#>  9    17 Recommendations Relative to t… 2020-03-30 https://doh.gov.ph/sites/def…
#> 10    18 Recommendations Relative to t… 2020-04-01 https://doh.gov.ph/sites/def…
#> # … with 15 more rows
```

`comotext` also holds 1 dataset of all [Department of
Health](http://www.doh.gov.ph) press releases to date. A description of
the `pressRelease` dataset can be found
[here](https://como-ph.github.io/comotext/reference/pressRelease.html).
This dataset has been generated using the `get_press_release()` function
(see description below) included in `comotext`. Related to this is the
dataset `prLinks` which holds the relative URL links for each of the
press releases in the [Department of Health](http://www.doh.gov.ph)
website to date. This dataset has been produced using the `get_pr_url()`
function (see description below) included in `comotext`. A description
of the `prLinks` dataset can be found
[here](https://como-ph.github.io/comotext/reference/prLinks.html).

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
#> # A tibble: 15 x 3
#>    url                                                             id date      
#>    <chr>                                                        <dbl> <date>    
#>  1 /doh-press-release/STATEMENT-ON-DATA-INTEGRITY                1920 2020-05-13
#>  2 /doh-press-release/HONORING-NURSE%E2%80%99S-DAY%3A-DOH-CALL…  8151 2020-05-13
#>  3 /doh-press-release/SAN-JUAN-CITY-THANKS-DOH-AS-COVID-19-CAS…  1911 2020-05-13
#>  4 /press-release/ADB-Sponsored-COVID-19-Lab-in-Pampanga-Launc…  1421 2020-05-10
#>  5 /press-release/ECQ-Buys-PH-Time-Continued-Practice-of-Healt…  5317 2020-05-09
#>  6 /press-release/biggest-mega-swabbing-center-in-moa-arena-to…  2977 2020-05-08
#>  7 /doh-press-release/Press%20Release/DUQUE-THANKS-NAVY-FRONTL…  4211 2020-05-07
#>  8 /doh-press-release/PH-GOV%E2%80%99T-RECEIVES-7-METRIC-TONS-…  2018 2020-05-07
#>  9 /doh-press-release/BEYOND-NUMBERS%3A-WHAT-THE-FLATTENING-CU…  2525 2020-05-07
#> 10 /doh-press-release/2ND-MEGA-SWABBING-CENTER-SET-TO-OPERATE%…  1441 2020-05-06
#> 11 /doh-press-release/NEW-MEGA-SWABBING-CENTER-TO-RAMP-UP-COVI…  1452 2020-05-06
#> 12 /doh-press-release/DOH%3A-NO-NEW-CASES-IN-41-PROVINCES%3B-P…  1141 2020-05-06
#> 13 /doh-press-release/PH-STARTS-TO-FLATTEN-CURVE%3B-ECQ%2C-PHY…  1681 2020-05-06
#> 14 /doh-press-release/DOH-LAUNCHES-MOBILE-PHONE-SURVEY-PART-2-…  4158 2020-05-05
#> 15 /doh-press-release/LGUs%2C-DOH-RAMP-UP-TESTING-CAPACITY%3B-…  3415 2020-05-05
```

The function `get_press_releases` creates a dataset of text of press
releases given a URL of a specific press release text and the date of
release. This information is provided for by `get_pr_url`. If we want to
get the text data of the press releases from page 1 of the press release
panel, we use:

``` r
## Extract URLs from DoH press releases page 1
prURL <- get_pr_url(pages = 1)

## Extract text from first press release
get_press_release(df = prURL[1, ])
#> # A tibble: 32 x 6
#>    linenumber text                              source type        id date      
#>         <int> <chr>                             <chr>  <chr>    <dbl> <date>    
#>  1          1 STATEMENT ON DATA INTEGRITY       DOH    press r…  1920 2020-05-13
#>  2          2 13, May 2020The Department of He… DOH    press r…  1920 2020-05-13
#>  3          3 UP COVID-19 Pandemic Response Te… DOH    press r…  1920 2020-05-13
#>  4          4 2020. The DOH has already taken … DOH    press r…  1920 2020-05-13
#>  5          5 24 and 25 data drops.These issue… DOH    press r…  1920 2020-05-13
#>  6          6 as well as other inconsistencies… DOH    press r…  1920 2020-05-13
#>  7          7 covid tracker@doh.gov.ph​. We ve…  DOH    press r…  1920 2020-05-13
#>  8          8 for raising their concerns.  We … DOH    press r…  1920 2020-05-13
#>  9          9 area nominal percentage of the w… DOH    press r…  1920 2020-05-13
#> 10         10 overall interpretation of data a… DOH    press r…  1920 2020-05-13
#> # … with 22 more rows
```

To get all the [DoH](https://www.doh.gov.ph) press releases available
from their [website](https://www.doh.gov.ph/press-releases), use:

``` r
## Extract URLs
pr <- get_pr_url(pages = 1:25)

## Extract all press releases text
pressRelease <- NULL

for(i in 1:nrow(pr)) {
  currentPR <- get_press_release(df = pr[i, ])

  pressRelease <- rbind(pressRelease, currentPR)
}
```

    #> # A tibble: 12,953 x 6
    #>    linenumber text                              source type        id date      
    #>         <int> <chr>                             <chr>  <chr>    <dbl> <date>    
    #>  1          1 ADB-Sponsored COVID-19 Lab in Pa… DOH    press r…  1421 2020-05-10
    #>  2          2 Press Release/10 May 2020Health … DOH    press r…  1421 2020-05-10
    #>  3          3 with Cabinet Secretary Karlo Nog… DOH    press r…  1421 2020-05-10
    #>  4          4 Health (DOH), inaugurated the st… DOH    press r…  1421 2020-05-10
    #>  5          5 funded Molecular and Diagnostic … DOH    press r…  1421 2020-05-10
    #>  6          6 Memorial General Hospital (JBLMG… DOH    press r…  1421 2020-05-10
    #>  7          7 2020. JBLMGH was the recipient o… DOH    press r…  1421 2020-05-10
    #>  8          8 to set up a Pandemic Sub nationa… DOH    press r…  1421 2020-05-10
    #>  9          9 country’s testing capacity by an… DOH    press r…  1421 2020-05-10
    #> 10         10 Ahmed M. Saeed, Vice President f… DOH    press r…  1421 2020-05-10
    #> # … with 12,943 more rows

This produces the same dataset as `pressRelease` included in `comotext`.

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
#> # A tibble: 2,785 x 6
#>    linenumber text                               source type       id date      
#>         <int> <chr>                              <chr>  <chr>   <dbl> <date>    
#>  1          1 WHEREAS, on January 31, 2020, upo… IATF   resolu…     9 2020-03-03
#>  2          2 Inter-Agency Task Force (IATF) fo… IATF   resolu…     9 2020-03-03
#>  3          3 a travel ban covering China, Maca… IATF   resolu…     9 2020-03-03
#>  4          4 SAR. On February 11, 2020, travel… IATF   resolu…     9 2020-03-03
#>  5          5 that it was being used as a trans… IATF   resolu…     9 2020-03-03
#>  6          6 WHEREAS, on February 14, 2020, tr… IATF   resolu…     9 2020-03-03
#>  7          7 lifted. On February 18, 2020, the… IATF   resolu…     9 2020-03-03
#>  8          8 exemptions in favor of certain cl… IATF   resolu…     9 2020-03-03
#>  9          9 SAR, and Macau SAR;                IATF   resolu…     9 2020-03-03
#> 10         10 WHEREAS, on February 26, 2020, fo… IATF   resolu…     9 2020-03-03
#> # … with 2,775 more rows
```

The `combine_iatf` function is a specialised wrapper of the
`combine_docs` function that specifically returns datasets containing
IATF resolutions. An additional argument `res` allows users to specify
which IATF resolutions to return. To get IATF resolution 10, 11, and 12,
the following call to `combine_iatf` is made as follows:

``` r
combine_iatf(docs = "resolution", res = 10:12)
#> # A tibble: 324 x 6
#>    linenumber text                               source type       id date      
#>         <int> <chr>                              <chr>  <chr>   <dbl> <date>    
#>  1          1 WHEREAS, Section 15 of Article II… IATF   resolu…    10 2020-03-09
#>  2          2 protect and promote the right to … IATF   resolu…    10 2020-03-09
#>  3          3 them:                              IATF   resolu…    10 2020-03-09
#>  4          4 WHEREAS, recognizing the need for… IATF   resolu…    10 2020-03-09
#>  5          5 preparedness and ensure efficient… IATF   resolu…    10 2020-03-09
#>  6          6 and prevent the spread of any pot… IATF   resolu…    10 2020-03-09
#>  7          7 (IATF) for the Management of Emer… IATF   resolu…    10 2020-03-09
#>  8          8 Executive Order No. 168, series o… IATF   resolu…    10 2020-03-09
#>  9          9 WHEREAS, on January 7, 2020, Chin… IATF   resolu…    10 2020-03-09
#> 10         10 a viral pneumonia outbreak in the… IATF   resolu…    10 2020-03-09
#> # … with 314 more rows
```

To check if only resolutions 10 to 12 have been returned:

``` r
combine_iatf(docs = "resolution", res = 10:12)[ , c("type", "id")]
#> # A tibble: 324 x 2
#>    type          id
#>    <chr>      <dbl>
#>  1 resolution    10
#>  2 resolution    10
#>  3 resolution    10
#>  4 resolution    10
#>  5 resolution    10
#>  6 resolution    10
#>  7 resolution    10
#>  8 resolution    10
#>  9 resolution    10
#> 10 resolution    10
#> # … with 314 more rows
```


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
Health](https://www.doh.gov.ph) are available publicly via the [DoH
website](https://www.doh.gov.ph).

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

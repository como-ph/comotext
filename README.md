
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comotext: R Tools to Extract COVID-19-Related Resolutions and Policies in the Philippines <img src="man/figures/comotext.png" width = "200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![Travis build
status](https://travis-ci.org/como-ph/comotext.svg?branch=master)](https://travis-ci.org/como-ph/comotext)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/como-ph/comotext?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comotext)
[![R build
status](https://github.com/como-ph/comotext/workflows/R-CMD-check/badge.svg)](https://github.com/como-ph/comotext/actions)
[![Codecov test
coverage](https://codecov.io/gh/como-ph/comotext/branch/master/graph/badge.svg)](https://codecov.io/gh/como-ph/comotext?branch=master)
[![DOI](https://zenodo.org/badge/255823130.svg)](https://zenodo.org/badge/latestdoi/255823130)
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

`comotext` currently has 28 datasets of COVID-19-related resolutions and
policies in the Philippines. These datasets are 28 resolutions made by
the Inter-Agency Task Force for the Management of Emerging Infectious
Diseases (IATF).

A description of the available datasets can be found
[here](https://como-ph.github.io/comotext/reference/index.html#section-datasets).

A table of the `29` IATF resolutions and the URLs to download them can
be generated using the function `get_iatf_links()` as follows:

``` r
get_iatf_links()
#> # A tibble: 29 x 6
#>       id title                   date       source type   url                   
#>    <dbl> <chr>                   <date>     <chr>  <chr>  <chr>                 
#>  1     9 Recommendations for th… 2020-03-03 IATF   resol… https://doh.gov.ph/si…
#>  2    10 Recommendations for th… 2020-03-09 IATF   resol… https://doh.gov.ph/si…
#>  3    11 Recommendations for th… 2020-03-12 IATF   resol… https://doh.gov.ph/si…
#>  4    12 Recommendations for th… 2020-03-13 IATF   resol… https://doh.gov.ph/si…
#>  5    13 Recommendations for th… 2020-03-17 IATF   resol… https://doh.gov.ph/si…
#>  6    14 Resolutions Relative t… 2020-03-20 IATF   resol… https://doh.gov.ph/si…
#>  7    15 Resolutions Relative t… 2020-03-25 IATF   resol… https://doh.gov.ph/si…
#>  8    16 Additional Guidelines … 2020-03-30 IATF   resol… https://doh.gov.ph/si…
#>  9    17 Recommendations Relati… 2020-03-30 IATF   resol… https://doh.gov.ph/si…
#> 10    18 Recommendations Relati… 2020-04-01 IATF   resol… https://doh.gov.ph/si…
#> # … with 19 more rows
```

`comotext` also holds 1 dataset of all [Department of
Health](http://www.doh.gov.ph) press releases to date. A description of
the `dohRelease` dataset can be found
[here](https://como-ph.github.io/comotext/reference/dohRelease.html).
This dataset has been generated using the `get_doh_release()` function
(see description below) included in `comotext`. Related to this is the
dataset `dohLinks` which holds the relative URL links for each of the
press releases in the [Department of Health](http://www.doh.gov.ph)
website to date. This dataset has been produced using the
`get_doh_links()` function (see description below) included in
`comotext`. A description of the `dohLinks` dataset can be found
[here](https://como-ph.github.io/comotext/reference/dohLinks.html).

### Extracting text data from press releases

Press releases issued by the [Department of
Health](https://www.doh.gov.ph) are available publicly via their
[website](https://www.doh.gov.ph/press-releases). The structure of the
press releases page is that the section with the links to the press
releases text is in a panel within the web page with the panel itself
having pagination with each page containing links to 28 press releases
with press releases ordered in reverse chronological order.

The function `get_doh_links()` extracts the relative URL links to each
of the press releases on a current page within the press releases panel.
If we want to get the absolute URL links for the press releases on page
1 of the press releases panel, we use:

``` r
get_doh_links(pages = 1)
#> # A tibble: 15 x 6
#>       id title                   date       source type   url                   
#>    <dbl> <chr>                   <date>     <chr>  <chr>  <chr>                 
#>  1  4158 "DOH TO DEPUTIZE MED G… 2020-05-19 DOH    press… https://www.doh.gov.p…
#>  2  4158 "DOH ENCOURAGES VIRTUA… 2020-05-18 DOH    press… https://www.doh.gov.p…
#>  3  1311 "Malasakit: panlaban n… 2020-05-16 DOH    press… https://www.doh.gov.p…
#>  4  5241 "EXPERTS RALLY BEHIND … 2020-05-14 DOH    press… https://www.doh.gov.p…
#>  5  5241 "GOVERNMENT OFFERS FUL… 2020-05-14 DOH    press… https://www.doh.gov.p…
#>  6  1452 "NEW QUARANTINE SITE I… 2020-05-13 DOH    press… https://www.doh.gov.p…
#>  7  1920 "STATEMENT ON DATA INT… 2020-05-13 DOH    press… https://www.doh.gov.p…
#>  8  8151 "HONORING NURSE’S DAY:… 2020-05-13 DOH    press… https://www.doh.gov.p…
#>  9  1911 "SAN JUAN CITY THANKS … 2020-05-13 DOH    press… https://www.doh.gov.p…
#> 10  1421 "ADB-Sponsored COVID-1… 2020-05-10 DOH    press… https://www.doh.gov.p…
#> 11  5317 "ECQ Buys PH Time; Con… 2020-05-09 DOH    press… https://www.doh.gov.p…
#> 12  2977 "BIGGEST MEGA SWABBING… 2020-05-08 DOH    press… https://www.doh.gov.p…
#> 13  4211 "DUQUE THANKS NAVY FRO… 2020-05-07 DOH    press… https://www.doh.gov.p…
#> 14  2018 "PH GOV’T RECEIVES 7 M… 2020-05-07 DOH    press… https://www.doh.gov.p…
#> 15  2525 "BEYOND\tNUMBERS:\tWHA… 2020-05-07 DOH    press… https://www.doh.gov.p…
```

The function `get_doh_release()` creates a dataset of text of press
releases given a URL of a specific press release text and the date of
release. This information is provided for by `get_doh_links()`. If we
want to get the text data of the press releases from page 1 of the press
release panel, we use:

``` r
## Extract URLs from DoH press releases page 1
prURL <- get_doh_links(pages = 1)

## Extract text from first press release
get_doh_release(df = prURL[1, ])
#> # A tibble: 49 x 6
#>    linenumber text                              source type        id date      
#>         <int> <chr>                             <chr>  <chr>    <dbl> <date>    
#>  1          1 DOH TO DEPUTIZE MED GRADS TO ASS… DOH    press r…  4158 2020-05-19
#>  2          2 Press Release/18 May 2020 Consis… DOH    press r…  4158 2020-05-19
#>  3          3 11469 or the “Bayanihan to Heal … DOH    press r…  4158 2020-05-19
#>  4          4 of 1959,” the Department of Heal… DOH    press r…  4158 2020-05-19
#>  5          5 2020-0169 last Saturday, which a… DOH    press r…  4158 2020-05-19
#>  6          6 practice of medicine as deputize… DOH    press r…  4158 2020-05-19
#>  7          7 of registration from the Profess… DOH    press r…  4158 2020-05-19
#>  8          8 in the President the power “to e… DOH    press r…  4158 2020-05-19
#>  9          9 complement or supplement the cur… DOH    press r…  4158 2020-05-19
#> 10         10 R.A. 2382 stipulates “Medical gr… DOH    press r…  4158 2020-05-19
#> # … with 39 more rows
```

To get all the [DoH](https://www.doh.gov.ph) press releases available
from their [website](https://www.doh.gov.ph/press-releases), use:

``` r
## Extract URLs
pr <- get_doh_links(pages = 1:25)

## Extract all press releases text
pressRelease <- NULL

for(i in 1:nrow(pr)) {
  currentPR <- get_doh_release(df = pr[i, ])

  pressRelease <- rbind(pressRelease, currentPR)
}
```

    #> # A tibble: 13,325 x 6
    #>    linenumber text                              source type        id date      
    #>         <int> <chr>                             <chr>  <chr>    <dbl> <date>    
    #>  1          1 DOH TO DEPUTIZE MED GRADS TO ASS… DOH    press r…  4158 2020-05-19
    #>  2          2 Press Release/18 May 2020 Consis… DOH    press r…  4158 2020-05-19
    #>  3          3 11469 or the “Bayanihan to Heal … DOH    press r…  4158 2020-05-19
    #>  4          4 of 1959,” the Department of Heal… DOH    press r…  4158 2020-05-19
    #>  5          5 2020-0169 last Saturday, which a… DOH    press r…  4158 2020-05-19
    #>  6          6 practice of medicine as deputize… DOH    press r…  4158 2020-05-19
    #>  7          7 of registration from the Profess… DOH    press r…  4158 2020-05-19
    #>  8          8 in the President the power “to e… DOH    press r…  4158 2020-05-19
    #>  9          9 complement or supplement the cur… DOH    press r…  4158 2020-05-19
    #> 10         10 R.A. 2382 stipulates “Medical gr… DOH    press r…  4158 2020-05-19
    #> # … with 13,315 more rows

This produces the same dataset as `dohRelease` included in `comotext`.

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
#> # A tibble: 3,186 x 6
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
#> # … with 3,176 more rows
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


<!-- README.md is generated from README.Rmd. Please edit that file -->

# comotext: R Tools to Extract COVID-19-Related Resolutions and Policies in the Philippines

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

`comotext` is in still in active development. You can install the
development version of `comotext` from
[GitHub](https://github.com/como-ph/comotext) with:

``` r
if(!require(remotes)) install.packages("remotes")
remotes::install_github("como-ph/comotext")
```

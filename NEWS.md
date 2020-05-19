## comotext v0.2.0

* created new versions of `get_` functions to allow for naming of source of text data; deprecation process started on previous versions

* re-structured the output text tibbles from the functions to a more logical sequence of data columns with a general sequence of `linenumber`, `identifier`, `text`, `date`, `source`, `type`, `url` whichever is present for the given tibble

* converted URLs to absolute URLs rather than relative URLs

* renamed datasets to include source of data as prefix to the name


# comotext v0.1.0

* Created pull data functions for the Department of Health (DoH) press releases found at [https://www.doh.gov.ph/press-releases](https://www.doh.gov.ph/press-releases)

* Created datasets of press releases from the DoH using the pull data functions above

* Created datasets of the resolutions released by the Interagency Task Force for the Management of Emerging Infectious Diseases (IATF) found at [https://www.doh.gov.ph/COVID-19/IATF-Resolutions](https://www.doh.gov.ph/COVID-19/IATF-Resolutions)

* Created combine functions to put together different types of text data available via the package

* Created `README` in Rmarkdown to describe the `comotext` package 

* Added a `NEWS.md` file to track changes to the package.

* Created `pkgdown` site using `flatly` bootstrap template consistent with stylesheet used for the CoMo app.

* Created CI/CD setup using Travis [![Travis build status](https://travis-ci.org/como-ph/comotext.svg?branch=master)](https://travis-ci.org/como-ph/comotext) and Appveyor [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/como-ph/comotext?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comotext)

* Created automated unit testing using `testthat` package and setup code coverage checker using `codecov` [![Codecov test coverage](https://codecov.io/gh/como-ph/comotext/branch/master/graph/badge.svg)](https://codecov.io/gh/como-ph/comotext?branch=master)

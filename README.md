
<!-- README.md is generated from README.Rmd. Please edit that file -->

# epar

<!-- badges: start -->

<!-- badges: end -->

The goal of epar is to …

## Installation

You can install the development version of epar from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("faithkwon/epar")
```

## Examples

This is a basic example which shows you how to solve a common problem:

``` r
library(epar)
compare_states(ma_2024, tx_2024)
#> Your two states are:  MA  and  TX . 
#> MA  has  820  chemical releases. 
#>  TX  has  9522 chemical releases. 
#> 42.07 % of  MA 's chemical releases are classified as hazardous by the Clean Air Act. 
#>  33.73 % of  TX 's chemical releases are hazardous. 
#> 27.8 % of  MA 's chemical releases are classified as carcinogens. 
#>  30.27 % of  TX 's chemical releases are carcinogens.
```

    #> Warning in st_point_on_surface.sfc(sf::st_zm(x)): st_point_on_surface may not
    #> give correct results for longitude/latitude data

<img src="man/figures/README-choropleth-1.png" width="100%" />

Note: You’ll still need to render `README.Rmd` regularly, to keep
`README.md` up-to-date. `devtools::build_readme()` is handy for this. In
that case, don’t forget to commit and push the resulting figure files,
so they display on GitHub and CRAN.

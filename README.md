
<!-- README.md is generated from README.Rmd. Please edit that file -->

# epar

<!-- badges: start -->

<!-- badges: end -->

The goal of epar is to explore chemical release data that is made
available by the Environmental Protection Agency (EPA) in their Toxics
Release Inventory (TRI). Data is reported every year by both industrial
and federal facilities, which is accessible on the EPA government
website. This data includes information on the properties of the
released chemical, relevant facility and industry characteristics, and
location of release. The epar package has tools to parse through this
data and learn more about chemical releases in a number of different
ways, including visualizations like maps and also summary statistics.

What is the top chemical release industry operating in Massachusetts,
and what percentage of those releases are carcinogenic? Which county in
Texas is responsible for the highest number of chemical releases? What
percentage of releases contain metal? These are the kinds of questions
you can answer with the epar package.

## Installation

You can install the development version of epar from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("faithkwon/epar")
```

Important note: installed size is ~6.1Mb.

## Examples

This is a basic example of getting the summary statistics for two
different states for comparison:

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

Another example is mapping the number of chemical releases by county:

    #> Warning in st_point_on_surface.sfc(sf::st_zm(x)): st_point_on_surface may not
    #> give correct results for longitude/latitude data

<img src="man/figures/README-choropleth-1.png" width="100%" />

Delete this eventually: You’ll still need to render `README.Rmd`
regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is
handy for this. In that case, don’t forget to commit and push the
resulting figure files, so they display on GitHub and CRAN. l

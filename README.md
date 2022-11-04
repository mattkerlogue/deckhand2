
<!-- README.md is generated from README.Rmd. Please edit that file -->

# deckhand2

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/deckhand2)](https://CRAN.R-project.org/package=deckhand2)
<!-- badges: end -->

`{deckhand2}` is an extension to the `{pagedown}` package that uses the
CSS grid layout module to provide extensive layout control of page based
R Markdown reports, such as when creating slide decks.

**This package is currently under development and not yet intended for
general use.** You can track general progress in the lead
[issue](https://github.com/mattkerlogue/deckhand2/issues/1).

## Installation

``` r
install.packages("remotes")
remotes::install.github("mattkerlogue/deckhand2")
```

## History & purpose

`{deckhand2}` is a generalised successor to the `{deckhand}` package
that I developed when working at the Cabinet Office. Individuals working
in other institutions have started to use that package, forking it and
making relevant adaptations for their own organisational set-up. Thus
{deckhand2} is intended as a successor to the {deckhand} that provides a
more generalised approach for working with CSS grid-layout and the
underlying paged media framework provided by {pagedown}.

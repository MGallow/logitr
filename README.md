logitr
================

[![Build
Status](https://travis-ci.org/MGallow/logitr.svg?branch=master)](https://travis-ci.org/MGallow/logitr)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/logitr)](https://cran.r-project.org/package=logitr)

### \*\*\*This package is experimental and not regularly maintained. It is recommended to use {glmnet} instead\!

## Overview

`logitr` is an R package for linear and logistic regression with
optional ridge and bridge regularization penalties. A (possibly
incomplete) list of functions contained in the package can be found
below:

  - `logisticr()` computes the coefficient estimates for logistic
    regression (ridge and bridge regularization optional)
  - `linearr()` computes the linear regression coefficient estimates
    (ridge regularization and weights optional)
  - `predict.logisticr()` generates predictions and loss metrics for
    logistic regression
  - `predict.linearr()` generates predictions and loss metric for linear
    regression

See [vignette](https://mgallow.github.io/logitr/) or
[manual](https://github.com/MGallow/logitr/blob/master/logitr.pdf).

## Installation

``` r
# The easiest way to install is from the development version from GitHub:
# install.packages("devtools")
devtools::install_github("MGallow/logitr")
```

If there are any issues/bugs, please let me know:
[github](https://github.com/MGallow/logitr/issues). You can also contact
me via my [website](https://mgallow.github.io/). Pull requests are
welcome\!

## Usage

``` r
library(logitr)

#we will use the iris data set
X = dplyr::select(iris, -c(Species, Sepal.Length))
y = dplyr::select(iris, Sepal.Length)
y_class = ifelse(dplyr::select(iris, Species) == "setosa", 1, 0)

#ridge regression (use CV for optimal lambda)
linearr(X, y, penalty = "ridge")
```

    ## 
    ## Call: linearr(X = X, y = y, penalty = "ridge")
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.1    NaN
    ## 
    ## MSE:
    ## [1] 0.09631325
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept  1.87785
    ##            0.64624
    ##            0.70231
    ##           -0.54160

``` r
#ridge logistic regression (IRLS) (use CV for optimal lambda)
logisticr(X, y_class, penalty = "ridge")
```

    ## 
    ## Call: logisticr(X = X, y = y_class, penalty = "ridge")
    ## 
    ## Iterations:
    ## [1] 18
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]    0    NaN
    ## 
    ## MSE:
    ## [1] 8.0815e-14
    ## 
    ## logloss:
    ## [1] 6.929591e-06
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##                [,1]
    ## intercept   7.88535
    ##             8.89485
    ##            -7.54863
    ##           -18.60425

``` r
#ridge logistic regression (MM)
logisticr(X, y_class, lam = 0.1, penalty = "ridge", method = "MM")
```

    ## 
    ## Call: logisticr(X = X, y = y_class, lam = 0.1, penalty = "ridge", method = "MM")
    ## 
    ## Iterations:
    ## [1] 5459
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.1    NaN
    ## 
    ## MSE:
    ## [1] 5.134801e-05
    ## 
    ## logloss:
    ## [1] 0.3956563
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept  6.27623
    ##            1.54082
    ##           -3.64177
    ##           -1.63050

``` r
#bridge logistic regression (MM)
fit = logisticr(X, y_class, lam = 0.1, alpha = 1.2, penalty = "bridge")
```

    ## [1] "using MM algorithm..."

``` r
fit
```

    ## 
    ## Call: logisticr(X = X, y = y_class, lam = 0.1, alpha = 1.2, penalty = "bridge")
    ## 
    ## Iterations:
    ## [1] 26021
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.1    1.2
    ## 
    ## MSE:
    ## [1] 2.749702e-05
    ## 
    ## logloss:
    ## [1] 0.1878654
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept 13.08031
    ##            0.61701
    ##           -5.71684
    ##           -0.23004

``` r
#predict using bridge logistic regression estimates
predict(fit, X[1:3,], y_class[1:3])
```

    ## $fitted.values
    ##           [,1]
    ## [1,] 0.9992467
    ## [2,] 0.9989747
    ## [3,] 0.9994881
    ## 
    ## $class
    ##      [,1]
    ## [1,]    1
    ## [2,]    1
    ## [3,]    1
    ## 
    ## $MSE
    ## [1] 6.269174e-07
    ## 
    ## $log.loss
    ## [1] 0.002291457
    ## 
    ## $misclassification
    ## [1] 0

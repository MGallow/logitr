logitr
================

### \*\*\*This package is no longer maintained.

See [vignette](https://htmlpreview.github.io/?https://github.com/MGallow/logitr/blob/master/Vignette.html) or [manual](https://github.com/MGallow/logitr/blob/master/logitr.pdf).

Overview
--------

`logitr` is an R package for linear and logistic regression with optional ridge and bridge regularization penalties. A (possibly incomplete) list of functions contained in the package can be found below:

-   `logisticr()` computes the coefficient estimates for logistic regression (ridge and bridge regularization optional)
-   `linearr()` computes the linear regression coefficient estimates (ridge regularization and weights optional)
-   `predict.logisticr()` generates predictions and loss metrics for logistic regression
-   `predict.linearr()` generates predictions and loss metric for linear regression

Installation
------------

``` r
# The easiest way to install is from the development version from GitHub:
# install.packages("devtools")
devtools::install_github("MGallow/logitr")
```

If there are any issues/bugs, please let me know: [github](https://github.com/MGallow/logitr/issues). You can also contact me via my [website](http://users.stat.umn.edu/~gall0441/). Pull requests are welcome!

Usage
-----

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
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.2    NaN
    ## 
    ## MSE:
    ## [1] 0.09637305
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept  5.84333
    ##            0.28061
    ##            1.21920
    ##           -0.39335

``` r
#ridge logistic regression (IRLS) (use CV for optimal lambda)
logisticr(X, y_class, penalty = "ridge")
```

    ## 
    ## Iterations:
    ## [1] 17
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]    0    NaN
    ## 
    ## MSE:
    ## [1] 5.838776e-13
    ## 
    ## logloss:
    ## [1] 1.874393e-05
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##                [,1]
    ## intercept -14.39486
    ##             3.66789
    ##           -12.58531
    ##           -12.88373

``` r
#ridge logistic regression (MM)
logisticr(X, y_class, lam = 0.1, penalty = "ridge", method = "MM")
```

    ## 
    ## Iterations:
    ## [1] 2204
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.1    NaN
    ## 
    ## MSE:
    ## [1] 7.253825e-05
    ## 
    ## logloss:
    ## [1] 0.5151693
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept -3.47091
    ##            1.44228
    ##           -3.45208
    ##           -3.05080

``` r
#bridge logistic regression (MM)
fit = logisticr(X, y_class, lam = 0.1, alpha = 1.2, penalty = "bridge")
```

    ## [1] "using MM algorithm..."

``` r
fit
```

    ## 
    ## Iterations:
    ## [1] 6871
    ## 
    ## Tuning parameters:
    ##       lam  alpha
    ## [1,]  0.1    1.2
    ## 
    ## MSE:
    ## [1] 1.50151e-05
    ## 
    ## logloss:
    ## [1] 0.2262398
    ## 
    ## misclassification:
    ## [1] 0
    ## 
    ## Coefficients:
    ##               [,1]
    ## intercept -4.40081
    ##            1.35741
    ##           -4.74639
    ##           -3.10466

``` r
#predict using bridge logistic regression estimates
predict(fit, X[1:3,], y_class[1:3])
```

    ## $fitted.values
    ##              [,1]
    ## [1,] 0.0009910544
    ## [2,] 0.0005029803
    ## [3,] 0.0010600969
    ## 
    ## $class
    ##      [,1]
    ## [1,]    0
    ## [2,]    0
    ## [3,]    0
    ## 
    ## $MSE
    ## [1] 0.998298
    ## 
    ## $log.loss
    ## [1] 21.3611
    ## 
    ## $misclassification
    ## [1] 1

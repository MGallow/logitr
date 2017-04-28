## Matt Galloway



#' @title Logistic Regression
#' @description Computes the coefficient estimates for logistic regression. Ridge regularization and Bridge regularization optional.
#'
#' @param X matrix or data frame
#' @param y matrix or vector of response values 0,1
#' @param lam optional tuning parameter for Ridge regularization term. Defaults to `lam = 0`
#' @param alpha optional tuning parameter for Bridge regularization term. Defaults to 'alpha = 1.5'
#' @param penalty choose from c('None', 'Ridge', 'Bridge'). Defaults to 'None'
#' @param vec optional vector to specify which coefficients will be penalized
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to "IRLS"
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 10^-5
#' @param maxit maximum iterations. Defaults to 10^5
#' @return returns beta estimates (includes intercept), total iterations, and gradients.
#' @export
#' @examples
#' Logistic Regression
#' library(dplyr)
#' X = dplyr::select(iris, -Species)
#' y = dplyr::select(iris, Species)
#' y$Species = ifelse(y$Species == 'setosa', 1, 0)
#' logisticr(X, y)
#'
#' Ridge Logistic Regression with IRLS
#' logistir(X, y, lam = 0.1, penalty = "Ridge")
#'
#' Ridge Logistic Regression with MM
#' logisticr(X, y, lam = 0.1, penalty = "Ridge", method = "MM")
#'
#' Bridge Logistic Regression
#' (Defaults to MM -- IRLS will return error)
#' logisticr(X, y, lam = 0.1, alpha = 1.5, penalty = "Bridge")


logisticr = function(X, y, lam = 0, alpha = 1.5, penalty = "None", intercept = TRUE,
    method = "IRLS", tol = 10^(-5), maxit = 10^(5), vec = NULL) {

    # checks
    n = dim(X)[1]
    if (all(y == 1 | y == 0) == FALSE)
        stop("y must be binary!")
    if (is.null(vec)) {
        vec = 1
    }
    if ((alpha >= 2 | alpha <= 1)) stop("alpha must be between 1 and 2!")
    if (length(lam) > 1)
        stop("lam must be a scalar!")
    if (lam < 0)
        stop("lam must be nonnegative!")
    if ((lam > 0) & (penalty == "None")) stop("please specify penalty!")
    if ((penalty == "Bridge") & (method != "MM")){
      print("using MM algorithm...")
      method = "MM"
    }
    if (penalty %in% c("None", "Ridge", "Bridge") == FALSE)
        stop("incorrect penalty!")
    if ((penalty != "None") & (lam == 0))
        stop("please specify lam!")
    if (intercept == TRUE) {
        # if no first column of ones, then add it
        if (all(X[, 1] != rep(1, n))) {
            X = cbind(1, X)
        }
        # do not penalize intercept, if not specified
        if (length(vec) == 1) {
            p = dim(X)[2]
            vec = c(0, rep(1, p - 1))
        }
    }
    if (method %in% c("IRLS", "MM") == FALSE)
        stop("incorrect method!")


    # if IRLS algorithm...
    if (method == "IRLS") {

        # execute IRLS script
        logistic = IRLS(X, y, lam, intercept, tol,
            maxit, vec)

    }

    # if MM algorithm...
    #if (method == 'MM') {

      # execute MM script
      #logistic = MM(X, y, lam, penalty, intercept, tol, maxit, vec)

    #}

    returns = list(coefficients = logistic$coefficients,
        total.iterations = logistic$total.iterations, gradient = logistic$gradient)
    return(returns)

}

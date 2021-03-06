# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' @title K fold (c++)
#' @description creates vector of shuffled indices
#'
#' @param n number of eleemtns
#' @param K number of folds
#' @return returns vector
#' @examples
#' kfold(10, 3)
#'
NULL

#' @title CV Logisticc (c++)
#' @description Computes the coefficient estimates for logistic regression. ridge regularization and bridge regularization optional. This function is to be used with the "logisticc" function.
#'
#' @param X matrix
#' @param y matrix or vector of response values 0,1
#' @param lam vector of tuning parameters for ridge regularization term. Defaults to `lam = 0`
#' @param alpha vector of tuning parameters for bridge regularization term. Defaults to 'alpha = 1.5'
#' @param penalty choose from c('none', 'ridge', 'bridge'). Defaults to 'none'
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to 'IRLS'
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 1e-5
#' @param maxit maximum iterations. Defaults to 1e5
#' @param vec optional vector to specify which coefficients will be penalized
#' @param init optional initialization for MM algorithm
#' @param criteria specify the criteria for cross validation. Choose from c("mse", "logloss", "misclass"). Defauls to "logloss"
#' @param K specify number of folds in cross validation, if necessary
#' @keywords internal
#' @return returns best lambda, best alpha, and cross validation errors
#' @export
#'
CV_logisticc <- function(X, y, lam = 0L, alpha = 0L, penalty = "none", intercept = TRUE, method = "IRLS", tol = 1e-5, maxit = 1e4, vec = 0L, init = 0L, criteria = "logloss", K = 5L) {
    .Call('_logitr_CV_logisticc', PACKAGE = 'logitr', X, y, lam, alpha, penalty, intercept, method, tol, maxit, vec, init, criteria, K)
}

#' @title CV Linearc (c++)
#' @description Computes the coefficient estimates for linear regression. ridge regularization and bridge regularization optional. This function is to be used with the "linearc" function
#'
#' @param X matrix
#' @param y matrix or vector of response values 0,1
#' @param lam vector of tuning parameters for ridge regularization term. Defaults to `lam = 0`
#' @param alpha vector of tuning parameters for bridge regularization term. Defaults to 'alpha = 1.5'
#' @param penalty choose from c('none', 'ridge', 'bridge'). Defaults to 'none'
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to 'IRLS'
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 1e-5
#' @param maxit maximum iterations. Defaults to 1e5
#' @param vec optional vector to specify which coefficients will be penalized
#' @param init optional initialization for MM algorithm
#' @param K specify number of folds in cross validation, if necessary
#' @return returns best lambda, best alpha, cv.errors
#' @keywords internal
#'
CV_linearc <- function(X, y, lam = 0L, alpha = 0L, penalty = "none", weights = 0L, intercept = TRUE, kernel = FALSE, method = "SVD", tol = 1e-5, maxit = 1e4, vec = 0L, init = 0L, K = 5L) {
    .Call('_logitr_CV_linearc', PACKAGE = 'logitr', X, y, lam, alpha, penalty, weights, intercept, kernel, method, tol, maxit, vec, init, K)
}

#' @title Gradient of Logistic Regression (IRLS) (c++)
#' @description Computes the gradient of logistic regression (optional ridge regularization term). We use this to determine if the KKT conditions are satisfied. This function is to be used with the 'IRLSc' function.
#'
#' @param betas estimates (includes intercept)
#' @param X matrix
#' @param y response vector of 0,1
#' @param lam tuning parameter for ridge regularization term
#' @param vec vector to specify which coefficients will be penalized
#' @return returns the gradient
NULL

#' @title Iterative Re-Weighted Least Squares (c++)
#' @description Computes the logistic regression coefficient estimates using the iterative re-weighted least squares (IRLS) algorithm. This function is to be used with the 'logisticc' function.
#'
#' @param betas beta estimates (includes intercept)
#' @param X matrix
#' @param y matrix or vector of response 0,1
#' @param lam tuning parameter for regularization term
#' @param penalty choose from c('none', 'ridge'). Defaults to 'none'
#' @param intercept Defaults to TRUE
#' @param tol tolerance - used to determine algorithm convergence
#' @param maxit maximum iterations
#' @param vec optional vector to specify which coefficients will be penalized
#' @return returns beta estimates (includes intercept), total iterations, and gradients.
NULL

#' @title Logitc (c++)
#' @description Computes the logit for u
#' @param u some number
#' @return returns the logit of u
#' @keywords internal
#'
logitc <- function(u) {
    .Call('_logitr_logitc', PACKAGE = 'logitr', u)
}

#' @title Linearc (c++)
#' @description Computes the linear regression coefficient estimates (ridge and bridge penalization and weights, optional)
#' @param X matrix
#' @param y matrix
#' @param lam optional tuning parameter for ridge regularization term. Defaults to 'lam = 0'
#' @param alpha optional tuning parameter for bridge regularization term. Defaults to "alpha = 1.5"
#' @param penalty choose from c("none", "ridge", "bridge"). Defaults to "none"
#' @param weights optional vector of weights for weighted least squares
#' @param intercept add column of ones if not already present. Defaults to TRUE
#' @param kernel use linear kernel to compute ridge regression coefficeients. Defaults to TRUE when p >> n (for "SVD")
#' @param method optimization algorithm. Choose from "SVD" or "MM". Defaults to "SVD"
#' @param tol tolerance - used to determine algorithm convergence for "MM". Defaults to 10^-5
#' @param maxit maximum iterations for "MM". Defaults to 10^5
#' @param vec optional vector to specify which coefficients will be penalized
#' @param init optional initialization for MM algorithm
#' @return returns the coefficient estimates
#' @keywords internal
#'
linearc <- function(X, y, lam = 0, alpha = 1.5, penalty = "none", weights = 0L, intercept = TRUE, kernel = FALSE, method = "SVD", tol = 1e-5, maxit = 1e5, vec = 0L, init = 0L) {
    .Call('_logitr_linearc', PACKAGE = 'logitr', X, y, lam, alpha, penalty, weights, intercept, kernel, method, tol, maxit, vec, init)
}

#' @title Logistic Regression (c++)
#' @description Computes the coefficient estimates for logistic regression. ridge regularization and bridge regularization optional.
#'
#' @param X matrix
#' @param y matrix or vector of response values 0,1
#' @param lam optional tuning parameter for ridge regularization term. Defaults to `lam = 0`
#' @param alpha optional tuning parameter for bridge regularization term. Defaults to 'alpha = 1.5'
#' @param penalty choose from c('none', 'ridge', 'bridge'). Defaults to 'none'
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to 'IRLS'
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 1e-5
#' @param maxit maximum iterations. Defaults to 1e5
#' @param vec optional vector to specify which coefficients will be penalized
#' @param init optional initialization for MM algorithm
#' @return returns beta estimates (includes intercept), total iterations, and gradients.
#' @keywords internal
#'
logisticc <- function(X, y, lam = 0, alpha = 1.5, penalty = "none", intercept = TRUE, method = "IRLS", tol = 1e-5, maxit = 1e5, vec = 0L, init = 0L) {
    .Call('_logitr_logisticc', PACKAGE = 'logitr', X, y, lam, alpha, penalty, intercept, method, tol, maxit, vec, init)
}

#' @title Predict Logistic Regression (c++)
#' @description Generates prediction for logistic regression
#'
#' @param betas matrix of coefficientts
#' @param X matrix of (new) observations
#' @param y matrix of response values 0,1
#' @return predictions and loss metrics
#' @keywords internal
predict_logisticc <- function(betas, X, y = 0L) {
    .Call('_logitr_predict_logisticc', PACKAGE = 'logitr', betas, X, y)
}

#' @title Predict Linear Regression
#' @description Generates prediction for linear regression
#'
#' @param betas 'linearr' object or matrix of betas
#' @param X matrix of (new) observations
#' @param y matrix of response values
#' @return predictions and loss metrics
#' @keywords internal
predict_linearc <- function(betas, X, y = 0L) {
    .Call('_logitr_predict_linearc', PACKAGE = 'logitr', betas, X, y)
}


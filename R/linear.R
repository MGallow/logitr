## Matt Galloway


#' @title Linear
#' @description Computes the linear regression coefficient estimates (L2-penalization and weights, optional)
#'
#' @param X matrix or data frame
#' @param y matrix or data frame of response values
#' @param lam optional tuning parameter for L2 regularization term. Defaults to "lam = 0"
#' @param vec optional vector to specify which coefficients will be penalized
#' @param weights optional vector of weights for weighted least squares
#' @param intercept add column of ones if not already present. Defaults to TRUE
#' @return returns the coefficient estimates
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -c(Species, Sepal.Length))
#' y = dplyr::select(iris, Sepal.Length)
#' linear(X, y, lam = 0.1, weights = rep(1, 150))



linear = function(X, y, lam = 0, weights = NULL, intercept = TRUE, vec = NULL) {

  #checks
  n = dim(X)[1]
  if (is.null(vec)) {vec = 1}
  if (is.null(weights)){weights = rep(1, n)}
  if (length(weights) != n) stop("weights must be length ", n)
  if (length(lam) > 1) stop("lam must be a scalar!")
  if (lam < 0) stop("lam must be nonnegative!")
  if (intercept == TRUE){

    #if no first column of ones, then add it
    if (all(X[, 1] != rep(1, n))){
      X = cbind(1, X)
    }

    #do not penalize intercept
    p = dim(X)[2]
    vec = c(0, rep(1, p - 1))
  }

  W = diag(weights)
  X = sqrt(W) %*% as.matrix(X)
  y = sqrt(W) %*% as.matrix(y)

  #if p > n, linear kernel ridge regression
  if(p > n){

    # SVD
    svd = svd(X)

    # adjust d vector for regularization and diagonalize
    d_adj = diag(1/(svd$d^2 + lam*vec))

    # calculate beta estimates
    betas = t(X) %*% svd$u %*% d_adj %*% t(svd$u) %*% y

  }

  #else compute normal ridge regression
  else {

    # SVD
    svd = svd(X)

    # adjust d vector for regularization and diagonalize
    d_adj = diag(svd$d/(svd$d^2 + lam*vec))

    # calculate beta estimates
    betas = svd$v %*% d_adj %*% t(svd$u) %*% y

  }


  returns = list(Coefficients = betas)
  return(returns)
}



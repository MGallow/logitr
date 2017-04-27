## Matt Galloway


#' @title Logit
#' @description Computes the logit for u
#'
#' @param u some number. Ex: X %*% beta
#' @return returns the logit of u
#' @examples
#' logit(X %*% beta)


logitr = function(u) {

    # calculate logit probabilities
    exp(u)/(1 + exp(u))

}



##------------------------------------------------------------------------------------


#' @title Gradient of IRLS Logistic Regression
#' @description Computes the gradient of logistic regression. We use this to determine if the KKT conditions are satisfied. This function is to be used with the 'IRLS' function.
#'
#' @param betas beta estimates (includes intercept)
#' @param X matrix or data frame
#' @param y response vector of 0,1
#' @param lam tuning parameter for regularization term
#' @param vec vector to specify which coefficients will be penalized
#' @param weights vector of weights for IRLS
#' @param penalty choose from c('None', 'L2'). Defaults to 'None'
#' @return returns the gradient
#' @examples
#' gradient_IRLS_logistic(betas, X, y, lam = 0.1, penalty = 'L2')

## NOT RIGHT?!!?!?!!?
gradient_IRLS_logistic = function(betas, X, y, lam = 0,
    weights, penalty = "None", vec) {

    # checks
    n = dim(X)[1]
    if (is.null(vec)) {
        vec = rep(1, n)
    }
    if (is.null(weights)) {
        weights = rep(1, n)
    }
    if (length(weights) != n)
        stop("weights must be length ", n)

    # gradient for beta
    t(X) %*% diag(weights) %*% X %*% betas - t(X) %*% diag(weights) %*%
        y + lam * matrix(vec)

}



##--------------------------------------------------------------------------------------------


#' @title Iterative Re-Weighted Least Squares
#' @description Computes the logistic regression coefficient estimates using the iterative re-weighted least squares (IRLS) algorithm. This function is to be used with the 'logistic' function.
#'
#' @param X matrix or data frame
#' @param y matrix or vector of response 0,1
#' @param lam tuning parameter for regularization term
#' @param vec optional vector to specify which coefficients will be penalized
#' @param penalty Choose from c('None', 'L2'). Defaults to 'None'
#' @param intercept Defaults to TRUE
#' @param tol tolerance - used to determine algorithm convergence
#' @param maxit maximum iterations
#' @return returns beta estimates (includes intercept), total iterations, and gradients.
#' @examples
#' IRLS(X, y, n.list = c(rep(1, n)), lam = 0.1, alpha = 1.5)


# calculates the coefficient estimates for logistic
# regression (IRLS)
IRLS = function(X, y, lam = 0, penalty = "None", intercept = TRUE,
    tol = 10^(-5), maxit = 1e+05, vec = NULL) {

    # initialize
    n = dim(X)[1]
    p = dim(X)[2]
    X = as.matrix(X)
    y = as.matrix(y)
    betas = as.matrix(rep(1, p))
    weights = rep(1, n)
    iteration = 1
    grads = gradient_IRLS_logistic(betas, X, y, lam, weights,
        penalty, vec)

    # IRLS algorithm
    while ((iteration < maxit) & (max(abs(grads)) > tol)) {

        # update working data
        Xb = X %*% betas
        p = logitr(Xb)
        weights = as.numeric(p * (1 - p))
        z = (y - p)/weights + Xb

        # calculate new betas
        betas = linearr(X, z, lam, weights, penalty, intercept,
            vec)$coefficients

        # calculate updated gradients
        grads = gradient_IRLS_logistic(betas, X, y, lam,
            weights, penalty, vec)
        iteration = iteration + 1

    }

    returns = list(coefficients = betas, total.iterations = iteration,
        gradient = grads)
    return(returns)
}



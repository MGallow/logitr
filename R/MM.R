## Matt Galloway


#' @title Majorize-Minimization function
#' @description This function utilizes the MM algorithm. It will be used to compute the logistic regression coefficient estimates. This function is to be used with the 'logisticr' function.
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
MM = function(X, y, lam = 0, penalty = "None", intercept = TRUE,
    tol = 10^(-5), maxit = 1e+05, vec = NULL) {

    # initialize
    n = dim(X)[1]
    p = dim(X)[2]
    X = as.matrix(X)
    y = as.matrix(y)
    betas = as.matrix(rep(0.1, p))
    weights = rep(1, n)/n
    iteration = 1
    grads = gradient_logistic(betas, X, y, lam, penalty,
        vec)

    # IRLS algorithm
    while ((iteration < maxit) & (max(abs(grads)) > tol)) {

        # update working data
        Xb = X %*% betas
        P = logitr(Xb)
        weights = as.numeric(P * (1 - P))
        z = (y - P)/weights + Xb

        # calculate new betas
        betas = linearr(X, z, lam, weights, penalty, intercept)$coefficients

        # calculate updated gradients
        grads = gradient_logistic(betas, X, y, lam, penalty,
            vec)
        iteration = iteration + 1

    }

    returns = list(coefficients = betas, total.iterations = iteration,
        gradient = grads)
    return(returns)
}


## Matt Galloway


#' @title Softmax
#' @description Computes the probability for each observation in X being in class '1'.
#'
#' @param X matrix (includes intercept)
#' @param b beta estimates (includes intercept)
#' @return returns the estimated probability
#' @examples
#' softmax(X, b)


softmax = function(X, b) {
    
    # calculate softmax probabilities
    exp(X %*% b)/(1 + exp(X %*% b))
    
}



##------------------------------------------------------------------------------------


#' @title Gradient of IRLS Logistic Regression
#' @description Computes the gradient of logistic regression. We use this to determine if the KKT conditions are satisfied. This function is to be used with the 'IRLS' function.
#'
#' @param betas beta estimates (includes intercept)
#' @param X matrix or data frame
#' @param y response vector of 0,1
#' @param lam tuning parameter for regularization term
#' @param vec optional vector to specify which coefficients will be penalized
#' @param weights optional vector of weights for IRLS
#' @param penalty choose from BLAH. Defaults to 'L2'
#' @return returns the gradient
#' @examples
#' gradient_IRLS_logistic(betas, X, y, lam = 0.1, penalty = 'L2')


gradient_IRLS_logistic = function(betas, X, y, lam = 0, weights = NULL, penalty = "L2", 
    vec = NULL) {
    
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
    t(X) %*% diag(weights) %*% X %*% betas - t(X) %*% diag(weights) %*% y + lam * 
        matrix(vec)
    
}



##--------------------------------------------------------------------------------------------


#' @title Iterative Re-Weighted Least Squares
#' @description Computes the logistic regression coefficient estimates using the iterative re-weighted least squares (IRLS) algorithm. This function is to be used with the 'logistic' function.
#'
#' @param X matrix or data frame
#' @param y matrix or vector of response 0,1
#' @param lam tuning parameter for regularization term
#' @param vec optional vector to specify which coefficients will be penalized
#' @param weights optional vector of weights for IRLS
#' @param penalty choose from BLAH. Defaults to 'L2'
#' @param tol tolerance - used to determine algorithm convergence
#' @param maxit maximum iterations
#' @return returns beta estimates (includes intercept), total iterations, and gradients.
#' @export
#' @examples
#' IRLS(X, y, n.list = c(rep(1, n)), lam = 0.1, alpha = 1.5)


# calculates the coefficient estimates for logistic regression (IRLS)
IRLS = function(X, y, lam = 0, weights = NULL, penalty = "L2", tol = 10^(-5), 
    maxit = 1e+05, vec) {
    
    # if first column not vector of ones, add it
    n = dim(X)[1]
    if (all(X[, 1] != rep(1, n))) {
        X = cbind(1, X)
    }
    
    # dimensions of data
    p = dim(X)[2]
    X = as.matrix(X)
    y = as.matrix(y)
    
    # initialize
    iteration = 1
    delta = 10^(-5)
    b = as.matrix(rep(1, p))
    N = diag(n.list)
    grads = gradient_logistic_bridge(X, y, N, b, lam, alpha)
    
    # part of Q maximization function
    gamma = t(X) %*% ((0.25 + delta) * N) %*% X
    
    
    # IRLS algorithm
    while ((iteration < maxit) & (max(grads$grad) > tol)) {
        
        # adjust v vector
        v = as.numeric((b^2)^(alpha/2 - 1))
        v[1] = 0
        
        # qrsolve
        b = qr.solve(gamma + lam * diag(v), t(X) %*% N %*% (y - softmax(X, b)) + 
            gamma %*% b)
        
        # calculate updated gradients
        grads = gradient_logistic_bridge(X, y, N, b, lam, alpha)
        iteration = iteration + 1
        
    }
    
    
    returns = list(b = b, total.iterations = iteration, grads = grads)
    return(returns)
}



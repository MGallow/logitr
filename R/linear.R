## Matt Galloway


#' @title Linear Regression
#' @description Computes the linear regression coefficient estimates (ridge-penalization and weights, optional)
#'
#' @param X matrix or data frame
#' @param y matrix or data frame of response values
#' @param lam optional tuning parameter for ridge regularization term. If passing a list of values, the function will choose the optimal value based on K-fold cross validation. Defaults to 'lam = seq(0, 2, 0.1)'
#' @param alpha optional tuning parameter for bridge regularization term. If passing a list of values, the function will choose the optimal value based on K-fold cross validation. Defaults to 'alpha = 1.5'
#' @param penalty choose from c('none', 'ridge', 'bridge'). Defaults to 'none'
#' @param weights optional vector of weights for weighted least squares
#' @param intercept add column of ones if not already present. Defaults to TRUE
#' @param kernel use linear kernel to compute ridge regression coefficeients. Defaults to TRUE when p >> n (for 'SVD')
#' @param method optimization algorithm. Choose from 'SVD' or 'MM'. Defaults to 'SVD'
#' @param tol tolerance - used to determine algorithm convergence for 'MM'. Defaults to 10^-5
#' @param maxit maximum iterations for 'MM'. Defaults to 10^5
#' @param vec optional vector to specify which coefficients will be penalized
#' @param init optional initialization for MM algorithm
#' @param K specify number of folds for cross validation, if necessary
#' @return returns the selected tuning parameters, coefficient estimates, MSE, and gradients
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -c(Species, Sepal.Length))
#' y = dplyr::select(iris, Sepal.Length)
#' linearr(X, y, lam = 0.1, penalty = 'ridge')

linearr = function(X, y, lam = seq(0, 2, 0.1), alpha = 1.5, 
    penalty = c("none", "ridge", "bridge"), weights = NULL, 
    intercept = TRUE, kernel = FALSE, method = c("SVD", "MM"), 
    tol = 1e-05, maxit = 1e+05, vec = NULL, init = 1, K = 5) {
    
    # checks
    n = dim(X)[1]
    p = dim(X)[2]
    X = as.matrix(X)
    y = as.matrix(y)
    call = match.call()
    penalty = match.arg(penalty)
    method = match.arg(method)
    lam = sort(lam)
    if (penalty == "none") {
        lam = 0
        alpha = 1.5
    }
    if (is.null(weights)) {
        weights = rep(1, n)
    }
    vec_ = vec
    if (is.null(vec)) {
        vec_ = rep(1, p)
    }
    if (length(weights) != n) 
        stop("weights must be length ", n)
    if (all(alpha >= 2 | alpha <= 1)) 
        stop("alpha must be between 1 and 2!")
    if (all(lam >= 0) == FALSE) 
        stop("lam must be nonnegative!")
    if (kernel & all(lam == 0)) 
        stop("must specify lam to use kernel!")
    if (kernel & (penalty == "bridge")) 
        stop("cannot use kernel with bridge penalty!")
    if (all(lam == 0) & (penalty != "none")) {
        print("No penalty used: lam = 0")
        penalty = "none"
    }
    if ((penalty == "bridge") & (method != "MM")) {
        print("using MM algorithm...")
        method = "MM"
    }
    if (intercept) {
        # if no first column of ones, then add it
        if (all(X[, 1] != rep(1, n))) {
            X = cbind(1, X)
            p = dim(X)[2]
        }
        # do not penalize intercept, if not specified
        if (is.null(vec)) {
            vec_ = c(0, rep(1, p - 1))
        }
    }
    if (length(init) > 1) {
        if (p != length(init)) 
            stop("initialization wrong dimension!")
    }
    
    
    # CV needed?
    if ((length(lam) > 1 | length(alpha) > 1) & (penalty != 
        "none")) {
        
        # execute CV_logisticc
        CV = CV_linearc(X, y, lam, alpha, penalty, weights, 
            intercept, kernel, method, tol, maxit, vec_, 
            init, K)
        lam = CV$best.lam
        alpha = CV$best.alpha
    }
    
    # execute linearc
    linear = linearc(X, y, lam, alpha, penalty, weights, 
        intercept, kernel, method, tol, maxit, vec_, init)
    
    
    # add intercept name, if needed
    betas = linear$coefficients
    grads = linear$gradient
    if (intercept) {
        b1 = as.matrix(betas[1])
        rownames(b1) = "intercept"
        betas = rbind(b1, as.matrix(betas[-1, ]))
        g1 = as.matrix(grads[1])
        rownames(g1) = "intercept"
        grads = rbind(g1, as.matrix(grads[-1, ]))
    }
    
    # generate fitted values
    fit = predict_linearc(linear$coefficients, as.matrix(X), 
        y)
    
    # misc
    if (penalty == "none") {
        lam = NaN
    }
    if (penalty != "bridge") {
        alpha = NaN
    }
    parameters = matrix(c(lam, alpha), ncol = 2)
    colnames(parameters) = c("lam", "alpha")
    
    returns = list(call = call, parameters = parameters, 
        coefficients = betas, MSE = fit$MSE, gradient = grads)
    class(returns) = "linearr"
    return(returns)
}




##-----------------------------------------------------------------------------------





#' @title Print linearr object
#' @description Print linearr object.
#' @param x linearr class object
#' @param ... additional arguments
#' @keywords internal
#' @export
print.linearr = function(x, ...) {
    
    # print call
    cat("\nCall: ", paste(deparse(x$call), sep = "\n", collapse = "\n"), 
        "\n", sep = "")
    
    # print optimal tuning parameters
    cat("\nTuning parameters:\n")
    print.default(round(x$parameters, 3), print.gap = 2L, 
        quote = FALSE)
    
    # print MSE
    cat("\nMSE:\n")
    print.default(x$MSE, quote = FALSE)
    
    # print coefficients if dim <= 10
    if (nrow(x$coefficients) <= 20) {
        cat("\nCoefficients:\n")
        print.default(round(x$coefficients, 5))
    } else {
        cat("\n(...output suppressed due to large dimension!)\n")
    }
    
}

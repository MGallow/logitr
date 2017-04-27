## Matt Galloway



#' @title Logistic Regression
#' @description Computes the coefficient estimates for logistic regression. L2 regularization penalty optional.
#'
#' @param X matrix or data frame
#' @param y matrix or vector of response values 0,1
#' @param lam optional tuning parameter for L2 regularization term. Defaults to `lam = 0`
#' @param penalty choose from c('None', 'L2'). Defaults to 'None'
#' @param vec optional vector to specify which coefficients will be penalized
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to 'IRLS'
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 10^-5
#' @param maxit maximum iterations. Defaults to 10^5
#' @return returns the coefficient estimates
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -Species)
#' y = dplyr::select(iris, Species)
#' y$Species = ifelse(y$Species == 'setosa', 1, 0)
#' logisticr(X, y, lam = 0.1)


logisticr = function(X, y, lam = 0, penalty = "None", intercept = TRUE, 
    method = "IRLS", tol = 10^(-5), maxit = 10^(5), vec = NULL) {
    
    # checks
    n = dim(X)[1]
    if (is.null(vec)) {
        vec = 1
    }
    if (length(lam) > 1) 
        stop("lam must be a scalar!")
    if (lam < 0) 
        stop("lam must be nonnegative!")
    if (lam > 0) 
        print("using L2 penalty!")
    if (penalty %in% c("None", "L2") == FALSE) 
        stop("incorrect penalty!")
    if ((penalty != "None") & (lam == 0)) 
        stop("please specify lam!")
    if (intercept == TRUE) {
        # if no first column of ones, then add it
        if (all(X[, 1] != rep(1, n))) {
            X = cbind(1, X)
        }
        # do not penalize intercept, if not specified
        if (vec == 1) {
            p = dim(X)[2]
            vec = c(0, rep(1, p - 1))
        }
    }
    if (method %in% c("IRLS", "MM") == FALSE) 
        stop("incorrect method!")
    
    
    # if IRLS algorithm...
    if (method == "IRLS") {
        
        # execute IRLS script
        logistic = IRLS(X, y, lam, penalty, intercept, tol, 
            maxit, vec)
        
    }
    
    # if MM algorithm... if (method == 'MM') {
    
    # execute MM script logistic = MM(X, y, lam, penalty,
    # intercept, tol, maxit, vec)
    
    # }
    
    returns = list(oefficients = logistic$coefficients, 
        total.iterations = logistic$total.iterations, gradient = logistic$gradient)
    return(returns)
    
}

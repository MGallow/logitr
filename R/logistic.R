## Matt Galloway



#' @title Logistic Regression
#' @description Computes the coefficient estimates for logistic regression. Regularization penalty optional.
#'
#' @param X matrix or data frame
#' @param y matrix or vector of response values 0,1
#' @param lam optional tuning parameter for L2 regularization term. Defaults to `lam = 0`
#' @param penalty choose from BLAH. Defaults to 'L2'
#' @param vec optional vector to specify which coefficients will be penalized
#' @param intercept Defaults to TRUE
#' @param method optimization algorithm. Choose from 'IRLS' or 'MM'. Defaults to 'IRLS' if BLAH
#' @param tol tolerance - used to determine algorithm convergence. Defaults to 10^-5
#' @param maxit maximum iterations. Defaults to 10^5
#' @return returns the coefficient estimates
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -c(Species, Sepal.Length))
#' y = dplyr::select(iris, Sepal.Length)
#' logistic(X, y, lam = 0.1)


logistic = function(X, y, lam = 0, penalty = "L2", intercept = TRUE, method = "IRLS", 
    tol = 10^(-5), maxit = 10^(5), vec = NULL) {
    
    # checks
    n = dim(X)[1]
    if (length(lam) > 1) 
        stop("lam must be a scalar!")
    if (lam < 0) 
        stop("lam must be nonnegative!")
    if (penalty %in% c("L2") == FALSE) 
        stop("incorrect penalty!")
    if (intercept == TRUE) {
        
        # if no first column of ones, then add it
        if (all(X[, 1] != rep(1, n))) {
            X = cbind(1, X)
        }
    }
    if (method %in% c("IRLS", "MM") == FALSE) 
        stop("incorrect method!")
    
    
    # if IRLS algorithm...
    if (method == "IRLS") {
        
        # execute IRLS script
        logistic = IRLS()
        
    }
    
    # if MM algorithm...
    if (method == "MM") {
        
        # execute MM script
        logistic = MM()
        
    }
    
    returns = list(Coefficients = logistic$Coefficients)
    return(returns)
    
}

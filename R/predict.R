## Matt Galloway



#' @title Predict Logistic Regression
#' @description Generates prediction for logistic regression. Note that one can either input a 'logisticr' object or a matrix of beta coefficients.
#'
#' @param object 'logisticr' object or matrix of betas
#' @param X matrix or data frame of (new) observations
#' @param y optional, matrix or vector of response values 0,1
#' @export
#' @examples
#'
#' fitted = logisticr(X, y, lam = 0.1, penalty = 'ridge', method = 'MM')
#' predict.logisticr(fitted, X)


predict.logisticr = function(object, X, y = NULL) {
    
    # checks
    X = as.matrix(X)
    if (!is.null(y)) {
        y = as.matrix(y)
        if (nrow(X) != nrow(y)) 
            stop("X and y must have equal observations!")
        
        if (all(y == 1 | y == 0) == FALSE) 
            stop("y must be binary!")
    }
    
    # if object is list, extract betas
    if (class(object) == "list") {
        object = object$coefficients
    }
    
    # add intercept, if needed
    if (ncol(X) != nrow(object)) {
        X = cbind(1, X)
    }
    
    # fitted values
    fitted = logitr(X %*% object)
    class = round(fitted)
    
    # if y, return MSE, misclassification
    MSE = NULL
    misclassification = NULL
    if (!is.null(y)) {
        
        # calculate metrics
        MSE = mean((y - fitted)^2)
        Log.loss = sum(-y * log(fitted) - (1 - y) * log(1 - 
            fitted))
        misclassification = mean(y != class)
        
    }
    
    
    returns = list(fitted.values = fitted, class = class, 
        MSE = MSE, misclassification = misclassification)
    return(returns)
}



##------------------------------------------------------------------------------------




#' @title Predict Linear Regression
#' @description Generates prediction for linear regression. Note that one can either input a 'linearr' object or a matrix of beta coefficients.
#'
#' @param object 'linearr' object or matrix of betas
#' @param X matrix or data frame of (new) observations
#' @param y optional, matrix or vector of response values
#' @export
#' @examples
#'
#' fitted = linearr(X, y, lam = 0.1)
#' predict.linearr(fitted, X)


predict.linearr = function(object, X, y = NULL) {
    
    # checks
    X = as.matrix(X)
    if (!is.null(y)) {
        y = as.matrix(y)
        if (nrow(X) != nrow(y)) 
            stop("X and y must have equal observations!")
    }
    
    # if object is list, extract betas
    if (class(object) == "list") {
        object = object$coefficients
    }
    
    # add intercept, if needed
    if (ncol(X) != nrow(object)) {
        X = cbind(1, X)
    }
    
    # fitted values
    fitted = X %*% object
    
    # if y, return MSE, misclassification
    RSS = NULL
    MSE = NULL
    if (!is.null(y)) {
        
        # calculate metrics
        RSS = sum((y - fitted)^2)
        MSE = mean((y - fitted)^2)
        
    }
    
    
    returns = list(fitted.values = fitted, RSS = RSS, MSE = MSE)
    return(returns)
}
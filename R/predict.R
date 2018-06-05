## Matt Galloway



#' @title Predict Logistic Regression
#' @description Generates prediction for logistic regression. Note that one can either input a 'logisticr' object or a matrix of beta coefficients.
#'
#' @param object 'logisticr' object or matrix of betas
#' @param X matrix or data frame of (new) observations
#' @param y optional, matrix or vector of response values 0,1
#' @param ... additional arguments
#' @return predictions and loss metrics
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -Species)
#' y = dplyr::select(iris, Species)
#' y$Species = ifelse(y$Species == 'setosa', 1, 0)
#' logisticr(X, y)
#'
#' fitted = logisticr(X, y, lam = 0.1, penalty = 'ridge', method = 'MM')
#' predict(fitted, X)

predict.logisticr = function(object, X, y = NULL, ...) {
    
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
    if (class(object) == "logisticr") {
        object = object$coefficients
    }
    
    # add intercept, if needed
    if (ncol(X) != nrow(object)) {
        X = cbind(1, X)
    }
    
    # fitted values
    fitted = logitc(X %*% object)
    class = round(fitted)
    
    # if y, return MSE, misclassification
    MSE = NULL
    log.loss = NULL
    misclassification = NULL
    if (!is.null(y)) {
        
        # calculate metrics
        MSE = mean((y - fitted)^2)
        log.losses = -y * log(fitted) - (1 - y) * log(1 - 
            fitted)
        log.loss = sum(ifelse(is.nan(log.losses), 0, log.losses))
        misclassification = mean(y != class)
        
    }
    
    
    returns = list(fitted.values = fitted, class = class, 
        MSE = MSE, log.loss = log.loss, misclassification = misclassification)
    return(returns)
}



##------------------------------------------------------------------------------------




#' @title Predict Linear Regression
#' @description Generates prediction for linear regression. Note that one can either input a 'linearr' object or a matrix of beta coefficients.
#'
#' @param object 'linearr' object or matrix of betas
#' @param X matrix or data frame of (new) observations
#' @param y optional, matrix or vector of response values
#' @param ... additional arguments
#' @return predictions and loss metrics
#' @export
#' @examples
#' library(dplyr)
#' X = dplyr::select(iris, -c(Species, Sepal.Length))
#' y = dplyr::select(iris, Sepal.Length)
#' fitted = linearr(X, y, lam = 0.1)
#' predict(fitted, X)


predict.linearr = function(object, X, y = NULL, ...) {
    
    # checks
    X = as.matrix(X)
    if (!is.null(y)) {
        y = as.matrix(y)
        if (nrow(X) != nrow(y)) 
            stop("X and y must have equal observations!")
    }
    
    # if object is list, extract betas
    if (class(object) == "linearr") {
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

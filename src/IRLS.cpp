// Matt Galloway

#include <RcppArmadillo.h>
#include <Rcpp.h>
#include "linear.h"

using namespace Rcpp;

//' @title Logitc (c++)
//' @description Computes the logit for u
//' @param u some number
//' @return returns the logit of u
//' @keywords internal
//'
// [[Rcpp::export]]
arma::colvec logitc(const arma::colvec& u) {

    //calculate logit probabilities
    return arma::exp(u)/(1 + arma::exp(u));
}



//------------------------------------------------------------------------------------


//' @title Gradient of Logistic Regression (IRLS) (c++)
//' @description Computes the gradient of logistic regression (optional ridge regularization term). We use this to determine if the KKT conditions are satisfied. This function is to be used with the 'IRLSc' function.
//'
//' @param betas estimates (includes intercept)
//' @param X matrix
//' @param y response vector of 0,1
//' @param lam tuning parameter for ridge regularization term
//' @param vec vector to specify which coefficients will be penalized
//' @return returns the gradient

arma::colvec gradient_IRLS_logisticc(const arma::colvec& betas, const arma::mat& X, const arma::colvec& y, double lam = 0, const arma::colvec& vec = 0) {

  // gradient for beta
  return arma::trans(X) * (logitc(X * betas) - y) + lam * vec % betas;

}



//--------------------------------------------------------------------------------------------


//' @title Iterative Re-Weighted Least Squares (c++)
//' @description Computes the logistic regression coefficient estimates using the iterative re-weighted least squares (IRLS) algorithm. This function is to be used with the 'logisticc' function.
//'
//' @param betas beta estimates (includes intercept)
//' @param X matrix
//' @param y matrix or vector of response 0,1
//' @param lam tuning parameter for regularization term
//' @param penalty choose from c('none', 'ridge'). Defaults to 'none'
//' @param intercept Defaults to TRUE
//' @param tol tolerance - used to determine algorithm convergence
//' @param maxit maximum iterations
//' @param vec optional vector to specify which coefficients will be penalized
//' @return returns beta estimates (includes intercept), total iterations, and gradients.

List IRLSc(const arma::mat& X, const arma::colvec& y, double lam = 0, std::string penalty = "none", bool intercept = true, double tol = 1e-5, double maxit = 1e5, const arma::colvec& vec = 0, const arma::colvec& init = 0) {

  // initialize
  int n = X.n_rows, p = X.n_cols;
  arma::colvec betas = init;
  if (init.n_cols == 1){
    betas = 0.1*arma::ones<arma::colvec>(p)/n;
  }
  arma::colvec weights = arma::ones<arma::colvec>(n);
  int iteration = 1;
  arma::colvec grads = gradient_IRLS_logisticc(betas, X, y, lam, vec);

  // IRLS algorithm
  while ((iteration < maxit) & (arma::max(arma::abs(grads)) > tol)) {
    // update working data
    arma::mat Xb = X * betas;
    arma::colvec P = logitc(Xb);
    arma::colvec weights = P % (1 - P);
    arma::colvec z = (y - P) % (1/weights) + Xb;

    // calculate new betas
    bool kernel = false;
    double alpha = 0;
    std::string method = "SVD";
    List lin = linearc(X, z, lam, alpha, penalty, weights, intercept, kernel, method, tol, maxit, vec, betas);
    betas = as<NumericVector>(lin["coefficients"]);


    // calculate updated gradients
    grads = gradient_IRLS_logisticc(betas, X, y, lam, vec);
    iteration += 1;

    // R_CheckUserInterrupt
    if (iteration % 1000 == 0){
      R_CheckUserInterrupt();
    }
  }

  return List::create(Named("coefficients") = betas,
                      Named("total.iterations") = iteration,
                      Named("gradient") = grads);
}



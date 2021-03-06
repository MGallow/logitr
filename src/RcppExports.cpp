// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// CV_logisticc
List CV_logisticc(const arma::mat& X, const arma::colvec& y, const arma::colvec& lam, const arma::colvec& alpha, std::string penalty, bool intercept, std::string method, double tol, double maxit, arma::colvec vec, arma::colvec init, std::string criteria, int K);
RcppExport SEXP _logitr_CV_logisticc(SEXP XSEXP, SEXP ySEXP, SEXP lamSEXP, SEXP alphaSEXP, SEXP penaltySEXP, SEXP interceptSEXP, SEXP methodSEXP, SEXP tolSEXP, SEXP maxitSEXP, SEXP vecSEXP, SEXP initSEXP, SEXP criteriaSEXP, SEXP KSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< std::string >::type penalty(penaltySEXP);
    Rcpp::traits::input_parameter< bool >::type intercept(interceptSEXP);
    Rcpp::traits::input_parameter< std::string >::type method(methodSEXP);
    Rcpp::traits::input_parameter< double >::type tol(tolSEXP);
    Rcpp::traits::input_parameter< double >::type maxit(maxitSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type vec(vecSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type init(initSEXP);
    Rcpp::traits::input_parameter< std::string >::type criteria(criteriaSEXP);
    Rcpp::traits::input_parameter< int >::type K(KSEXP);
    rcpp_result_gen = Rcpp::wrap(CV_logisticc(X, y, lam, alpha, penalty, intercept, method, tol, maxit, vec, init, criteria, K));
    return rcpp_result_gen;
END_RCPP
}
// CV_linearc
List CV_linearc(const arma::mat& X, const arma::colvec& y, const arma::colvec& lam, const arma::colvec& alpha, std::string penalty, arma::colvec weights, bool intercept, bool kernel, std::string method, double tol, double maxit, arma::colvec vec, arma::colvec init, int K);
RcppExport SEXP _logitr_CV_linearc(SEXP XSEXP, SEXP ySEXP, SEXP lamSEXP, SEXP alphaSEXP, SEXP penaltySEXP, SEXP weightsSEXP, SEXP interceptSEXP, SEXP kernelSEXP, SEXP methodSEXP, SEXP tolSEXP, SEXP maxitSEXP, SEXP vecSEXP, SEXP initSEXP, SEXP KSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< std::string >::type penalty(penaltySEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type weights(weightsSEXP);
    Rcpp::traits::input_parameter< bool >::type intercept(interceptSEXP);
    Rcpp::traits::input_parameter< bool >::type kernel(kernelSEXP);
    Rcpp::traits::input_parameter< std::string >::type method(methodSEXP);
    Rcpp::traits::input_parameter< double >::type tol(tolSEXP);
    Rcpp::traits::input_parameter< double >::type maxit(maxitSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type vec(vecSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type init(initSEXP);
    Rcpp::traits::input_parameter< int >::type K(KSEXP);
    rcpp_result_gen = Rcpp::wrap(CV_linearc(X, y, lam, alpha, penalty, weights, intercept, kernel, method, tol, maxit, vec, init, K));
    return rcpp_result_gen;
END_RCPP
}
// logitc
arma::colvec logitc(const arma::colvec& u);
RcppExport SEXP _logitr_logitc(SEXP uSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::colvec& >::type u(uSEXP);
    rcpp_result_gen = Rcpp::wrap(logitc(u));
    return rcpp_result_gen;
END_RCPP
}
// linearc
List linearc(const arma::mat& X, const arma::colvec& y, double lam, double alpha, std::string penalty, arma::colvec weights, bool intercept, bool kernel, std::string method, double tol, double maxit, arma::colvec vec, arma::colvec init);
RcppExport SEXP _logitr_linearc(SEXP XSEXP, SEXP ySEXP, SEXP lamSEXP, SEXP alphaSEXP, SEXP penaltySEXP, SEXP weightsSEXP, SEXP interceptSEXP, SEXP kernelSEXP, SEXP methodSEXP, SEXP tolSEXP, SEXP maxitSEXP, SEXP vecSEXP, SEXP initSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< std::string >::type penalty(penaltySEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type weights(weightsSEXP);
    Rcpp::traits::input_parameter< bool >::type intercept(interceptSEXP);
    Rcpp::traits::input_parameter< bool >::type kernel(kernelSEXP);
    Rcpp::traits::input_parameter< std::string >::type method(methodSEXP);
    Rcpp::traits::input_parameter< double >::type tol(tolSEXP);
    Rcpp::traits::input_parameter< double >::type maxit(maxitSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type vec(vecSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type init(initSEXP);
    rcpp_result_gen = Rcpp::wrap(linearc(X, y, lam, alpha, penalty, weights, intercept, kernel, method, tol, maxit, vec, init));
    return rcpp_result_gen;
END_RCPP
}
// logisticc
List logisticc(const arma::mat& X, const arma::colvec& y, double lam, double alpha, std::string penalty, bool intercept, std::string method, double tol, double maxit, arma::colvec vec, arma::colvec init);
RcppExport SEXP _logitr_logisticc(SEXP XSEXP, SEXP ySEXP, SEXP lamSEXP, SEXP alphaSEXP, SEXP penaltySEXP, SEXP interceptSEXP, SEXP methodSEXP, SEXP tolSEXP, SEXP maxitSEXP, SEXP vecSEXP, SEXP initSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    Rcpp::traits::input_parameter< double >::type lam(lamSEXP);
    Rcpp::traits::input_parameter< double >::type alpha(alphaSEXP);
    Rcpp::traits::input_parameter< std::string >::type penalty(penaltySEXP);
    Rcpp::traits::input_parameter< bool >::type intercept(interceptSEXP);
    Rcpp::traits::input_parameter< std::string >::type method(methodSEXP);
    Rcpp::traits::input_parameter< double >::type tol(tolSEXP);
    Rcpp::traits::input_parameter< double >::type maxit(maxitSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type vec(vecSEXP);
    Rcpp::traits::input_parameter< arma::colvec >::type init(initSEXP);
    rcpp_result_gen = Rcpp::wrap(logisticc(X, y, lam, alpha, penalty, intercept, method, tol, maxit, vec, init));
    return rcpp_result_gen;
END_RCPP
}
// predict_logisticc
List predict_logisticc(const arma::colvec& betas, const arma::mat& X, const arma::colvec& y);
RcppExport SEXP _logitr_predict_logisticc(SEXP betasSEXP, SEXP XSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::colvec& >::type betas(betasSEXP);
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(predict_logisticc(betas, X, y));
    return rcpp_result_gen;
END_RCPP
}
// predict_linearc
List predict_linearc(const arma::colvec& betas, const arma::mat& X, const arma::colvec& y);
RcppExport SEXP _logitr_predict_linearc(SEXP betasSEXP, SEXP XSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::colvec& >::type betas(betasSEXP);
    Rcpp::traits::input_parameter< const arma::mat& >::type X(XSEXP);
    Rcpp::traits::input_parameter< const arma::colvec& >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(predict_linearc(betas, X, y));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_logitr_CV_logisticc", (DL_FUNC) &_logitr_CV_logisticc, 13},
    {"_logitr_CV_linearc", (DL_FUNC) &_logitr_CV_linearc, 14},
    {"_logitr_logitc", (DL_FUNC) &_logitr_logitc, 1},
    {"_logitr_linearc", (DL_FUNC) &_logitr_linearc, 13},
    {"_logitr_logisticc", (DL_FUNC) &_logitr_logisticc, 11},
    {"_logitr_predict_logisticc", (DL_FUNC) &_logitr_predict_logisticc, 3},
    {"_logitr_predict_linearc", (DL_FUNC) &_logitr_predict_linearc, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_logitr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}

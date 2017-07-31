
/******************************************************
 *
 *
 *
 *
 ******************************************************/

#include <iostream>
#include <Eigen/Dense>
#include "mex.h"

using namespace Eigen;
using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

  const mwSize *dim;
  dim = mxGetDimensions(prhs[0]);
  
  double *Aptr;
  Aptr = mxGetPr(prhs[0]);  
  
  MatrixXd A;
  A.resize(dim[0],dim[1]);
  A << Map<MatrixXd>(Aptr, dim[0], dim[1]);
  
  double factor;
  factor = mxGetScalar(prhs[1]);
  A = A.array()*factor;
    
  plhs[0] = mxCreateNumericMatrix(dim[0], dim[1], mxDOUBLE_CLASS, mxREAL);
  double *Out;
  Out = mxGetPr(plhs[0]);
  MatrixXd::Map(Out, dim[0], dim[1]) = A;
  
  return;
  
}
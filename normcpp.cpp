
/******************************************************
 *
 *
 *
 * mex -I/usr/include/eigen3 normcpp.cpp
 ******************************************************/

#include <Eigen/Dense>
#include "mex.h"

using namespace Eigen;
using namespace std;

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

  const mwSize *dim;
  dim = mxGetDimensions(prhs[0]);
  
  double *Aptr, *Bptr;
  Aptr = mxGetPr(prhs[0]);
   
  MatrixXd A;
  A.resize(dim[0],dim[1]);
  A << Map<MatrixXd>(Aptr, dim[0], dim[1]);
    
  plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
  double *Out;
  Out = mxGetPr(plhs[0]);
  MatrixXd::Map(Out, 1, 1) << A.norm();
    
  return;
  
}
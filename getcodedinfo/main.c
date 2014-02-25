#include <stdio.h>
#include "cutest.h"

#define EPS 1e-20

void classify_constr (integer ncon, logical *equatn) {
  logical has_eq = false, has_ineq = false;
  integer i;

  for (i = 0; i < ncon; i++) {
    if (equatn[i])
      has_eq = true;
    else
      has_ineq = true;
    if (has_eq && has_ineq)
      break;
  }

  if (has_eq && has_ineq)
    printf("gen ");
  else if (has_ineq)
    printf("inq ");
  else if (has_eq)
    printf("equ ");
  else
    printf("unc ");
}

void classify_linear (integer ncon, logical *linear) {
  logical has_linear = false;
  integer i;

  for (i = 0; i < ncon; i++) {
    if (linear[i]) {
      has_linear = true;
      break;
    }
  }
  if (has_linear)
    printf("lincon ");
  else
    printf("nlncon ");
}

void classify_bounds (integer nvar, doublereal *bl, doublereal *bu) {
  logical has_lower = false, has_upper = false, has_fixed = false;
  integer i;

  for (i = 0; i < nvar; i++) {
    if (bu[i] - bl[i] < EPS)
      has_fixed = true;
    if (bl[i] > -CUTE_INF)
      has_lower = true;
    if (bu[i] < CUTE_INF)
      has_upper = true;
    if (has_lower && has_upper && has_fixed)
      break;
  }

  if (has_lower && has_upper)
    printf("boxed ");
  else if (has_lower)
    printf("lower ");
  else if (has_upper)
    printf("upper ");
  else
    printf("nobnd ");

  if (has_fixed)
    printf("fixed ");
  else
    printf("nofix ");
}

int MAINENTRY () {
  doublereal *x, *bl, *bu;
  doublereal *y = 0, *cl = 0, *cu = 0;
  logical *equatn, *linear;
  integer efirst = 0, lfirst = 0, nvfirst = 0;
  char pname[10], *vnames, *cnames;
  char fname[10] = "OUTSDIF.d";
  integer nvar = 0, ncon = 0, nconE = 0, nconI = 0;
  integer funit = 42, ierr = 0, fout = 6, io_buffer = 11, status;
  integer i;

  FORTRAN_open(&funit, fname, &ierr);
  CUTEST_cdimen(&status, &funit, &nvar, &ncon);

  x  = (doublereal *) malloc(sizeof(doublereal) * nvar);
  bl = (doublereal *) malloc(sizeof(doublereal) * nvar);
  bu = (doublereal *) malloc(sizeof(doublereal) * nvar);

  vnames = (char *) malloc(10 * nvar);

  if (ncon > 0) {
    y  = (doublereal *) malloc(sizeof(doublereal) * ncon);
    cl = (doublereal *) malloc(sizeof(doublereal) * ncon);
    cu = (doublereal *) malloc(sizeof(doublereal) * ncon);

    equatn = (logical *) malloc(sizeof(logical) * ncon);
    linear = (logical *) malloc(sizeof(logical) * ncon);

    cnames = (char *) malloc(10 * ncon);

    CUTEST_csetup(&status, &funit, &fout, &io_buffer, &nvar, &ncon, x, bl, bu, 
        y, cl, cu, equatn, linear, &efirst, &lfirst, &nvfirst);

    for (i = 0; i < ncon; i++) {
      if (equatn[i] == true)
        nconE++;
      else
        nconI++;
    }

    CUTEST_cnames(&status, &nvar, &ncon, pname, vnames, cnames);
  } else {
    CUTEST_usetup(&status, &funit, &fout, &io_buffer, &nvar, x, bl, bu);
    CUTEST_unames(&status, &nvar, pname, vnames);
  }
  
  pname[9] = 0;
  printf("%9s %-9d %-9d %-9d ", pname, nvar, nconE, nconI);
  classify_constr(ncon, equatn);
  classify_linear(ncon, linear);
  classify_bounds(nvar, bl, bu);
  printf("\n");

  if (ncon > 0) {
    free(y);
    free(cl);
    free(cu);
    free(equatn);
    free(linear);
    free(cnames);
  }
  free(x);
  free(bl);
  free(bu);
  free(vnames);

  FORTRAN_close(&funit, &ierr);

  return 0;
}

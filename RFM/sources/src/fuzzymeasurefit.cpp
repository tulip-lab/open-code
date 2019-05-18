/********************* Fuzzy measure toolkit ******************************************

FuzzyMeasureFitLP estimates the values of a k-additive fuzzy measure based on
empirical data - the arguments and values of the discrete Choquet integral.
The empirical data, which consists of pairs (x,y), x \in [0,1]^n, y \in [0,1]
are fitted in the least absolute deviation sense, by converting this problem to
a linear programming problem. The result is an array containing the values of
the Mobius transform of the fuzzy measure, ordered according to set cardinalities.

See the header file for detailed description.

-------------------------------------------------------------------------------------
 *
 *      begin                : June 10 2007
 *		version				 : 1.0 
 *		copyright            : (C) 2007 by Gleb Beliakov
 *		email                : gleb@deakin.edu.au
 *
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the Lesser GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
**************************************************************************************/

#include <cstdio>
#include <cstdlib>
#include <iostream>
using namespace std;
#include <cmath>
#include <algorithm>
#include "lp_lib.h"
#include <R.h>
// note that programs using this code should be linked against lp_solve library,
// which should be downloaded and installed separatly. These references are only
// to the readers of that library.

#include "fuzzymeasuretools.h"

using namespace std;
  Less_than less_than1;              /* declare a comparison function object, to */

int	FuzzyMeasureFitLP(int n, int m, int K, int Kadd, double *v, double* XYData, int options, 
			double* indexlow, double* indexhigh, int option1, double* orness )
// K for data, Kadd for k-additive f.m.
// indexlow, indexhigh are 0-based for Shapley values (contain only singletos
// but are 1-based and in cardinality ordering (like the f.m. themselves, the first element = emptyset) 
// when they contain all  m values of all interaction indices
{


  int i,j,k,k1,res,i1;
  int result;
  unsigned int A,B,C;
  lprec		*MyLP;
  int RowsR,RowsC, RowsC1;
  int ColsR, ColsC;
  valindex *tempyk;
  double temp;

// calculate how many rows/columns we need

  RowsC1	= (cardpos[Kadd] - n-1); //how many non-singletons
  RowsR=K*2; RowsC = n + RowsC1*2;

  ColsR = RowsR;
  ColsC=0; // unknow at this stage

  MyLP = make_lp( RowsR+RowsC, 0);
  MyLP->do_presolve=FALSE;   
  set_verbose(MyLP,3);
  int itemp = RowsC+2 +1; // just the max number of entries per column

  double *row;
  int	 *rowno;
  row=new double[itemp];
  rowno=new int[itemp];
  int re;

// the first K columns
  rowno[0]=0;
  for(k=0;k<K; k++) { 
	    //rowno[0] is the obj. function
	    row[0] = XYData [k*(n+1)+n ];//y[k]; //
		rowno[1]=k+1;  // 1-based
		rowno[2]=k+1+ K;
		row[1]=-1; 
		row[2]= 1;
// now the vales of h_A
		for(i=0;i<n;i++) {// singletons
			row[2+i+1]=XYData[k*(n+1)+i];
			rowno[2+i+1] = RowsR +i +1;
		}

		for(i=0;i<RowsC1;i++) {
			row[2+i +n+1]=min_subset( &(XYData[k*(n+1)]), n, card2bit[i + 1 + n]) ;
			rowno[2+i +n+1] = RowsR + n + i +1;

			row[2+i +n + RowsC1+1]= - row[2+i +n+1] ;
			rowno[2+i+n + RowsC1+1] = RowsR + n + i +1  + RowsC1;
		}

		re=add_columnex(MyLP, itemp, row, rowno);

// now repeat everything, just change the sign
		for(i=0;i<itemp;i++) row[i]=-row[i];

		re=add_columnex(MyLP, itemp, row, rowno);
  }

  // next equality constraint = add to 1
  double wei=K; // this constraint is taken with that weight, to ensure it is actually satisfied 
  if(wei<1) wei=1;
  // despite roundoff errors 
  row[0]=wei; rowno[0]=0; k=1;
  for(i=0;i<RowsC1+n;i++) {
	  row[k]=wei;
	  rowno[k]= i+ RowsR+1;
	  k++;
  }
  for(i=0;i<RowsC1;i++) {
	  row[k]=-wei;
	  rowno[k]=i+1+ RowsC1+n+ RowsR;
	  k++;
  }
	re=add_columnex(MyLP, k, row, rowno);
// now reverse inequality
    for(i=0;i<k;i++) row[i]=-row[i];
	re=add_columnex(MyLP, k, row, rowno);

// now monotonicity constraints for all |A|>2

	row[0]=0; rowno[0]=0;
	for(A=n+1; A < m; A++){
//	cout<<"start subset  "<< A<<endl;
		C=card2bit[A];
		for(i=0;i<n;i++) if(IsInSet(C,i)) {
			k=1;
			for(B=1;B<=C;B++) if(IsInSet(B,i) && IsSubset(C,B)) {
				if(card[B]==1) {
					row[k]=1;
					rowno[k]=bit2card[B]+RowsR; //no need for +1, as it is 1-based
					k++;
				} else if(card[B] <= Kadd) {
					row[k]=1;
					rowno[k]=bit2card[B]+RowsR;
					k++;
				}
			}
			// finished loop for all B \subseteq A, now add the entries corresponding to -1
			k1=k;
			for(i1=1;i1<k1;i1++) if(rowno[i1]>RowsR+n) {
				rowno[k]=rowno[i1]+RowsC1;
				row[k]=-row[i1];
				k++;
			}
			re=add_columnex(MyLP, k, row, rowno);

		} // i 
	} // subsets

// add interaction indices if needed
	
	switch(options) {
		case 0: break; // no indices supplied
		case 3: // both shapley bounds supplied
		case 1: // shapley lower bounds supplied 
			if(indexlow!=NULL)
			for(i=0;i<n;i++) if(indexlow[i] > 0) {
				row[0]=indexlow[i];
				rowno[0]=0;
				row[1]=1;
				rowno[1]=RowsR+i+1; // singleton
				k=2;
				for(A=n+1; A < m; A++){
					C=card2bit[A];
					if(IsInSet(C,i) && (card[C] <= Kadd)) {
						row[k]=1.0/card[C];
						rowno[k] = A + RowsR;
						k++;
					}
				}
				k1=k;
				for(j=2;j<k1;j++) {row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++;}
				re=add_columnex(MyLP, k, row, rowno);
			}
			if(options==1) break;
		case 2: // shapley upper bounds supplied // almost the same as above, but change of sign
			if(indexhigh!=NULL)
			for(i=0;i<n;i++) if(indexhigh[i] < 1) {
				row[0]= -indexhigh[i];
				rowno[0]=0;
				row[1]= -1;
				rowno[1]=RowsR+i+1; // singleton
				k=2;
				for(A=n+1; A < m; A++){
					C=card2bit[A];
					if(IsInSet(C,i) && (card[C] <= Kadd)) {
						row[k]= -1.0/card[C];
						rowno[k] = A + RowsR;
						k++;
					}
				}
				k1=k;
				for(j=2;j<k1;j++) {row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++;}
				re=add_columnex(MyLP, k, row, rowno);
			}
			break;

		case 6: // all  bounds on interaction indices 
		case 4: // all lower bounds on interaction indices 
			if(indexlow!=NULL)
			for(A=1;A<m;A++) if(indexlow[A] > -1) {
				C=card2bit[A];
				row[0]=indexlow[A];
				rowno[0]=0;
				k=1;
				for(B=C; B < m; C++) if(IsSubset(B,C) && (card[B] <= Kadd)) {
					row[k]=1.0/(card[B]-card[C]+1.);
					rowno[k]=bit2card[B]+RowsR;
					k++;
				}
				k1=k;
				for(j=1;j<k1;j++) if(rowno[j]>RowsR+n) 
				{row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++; }
				re=add_columnex(MyLP, k, row, rowno);
			}
			if(options==4) break;
		case 5: // all upper bounds on interaction indices  // almost the same as above 
			if(indexhigh!=NULL)
			for(A=1;A<m;A++) if(indexhigh[A] < 1) {
				C=card2bit[A];
				row[0]= - indexhigh[A];
				rowno[0]=0;
				k=1;
				for(B=C; B < m; B++) if(IsSubset(B,C) && (card[B] <= Kadd)) {
					row[k]= -1.0/(card[B]-card[C]+1.);
					rowno[k]=bit2card[B]+RowsR;
					k++;
				}
				k1=k;
				for(j=1;j<k1;j++) if(rowno[j]>RowsR+n) 
				{row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++; }
				re=add_columnex(MyLP, k, row, rowno);
			}
			break;
	}

	// additional options:
	// bit 1 = specified orness value
	// bit 2 = add condition that f.m. is balanced
	// bit 3 = add condition of preservation of output orderings
	wei/=2.;
	if(option1 & 0x1 == 0x1) { // orness specified orness[0]=lower bound, orness[1]=upper bound
		if(orness[0]>0) {
			row[0]=orness[0] * wei; rowno[0]=0; k=1;
			for(A=1; A < m; A++){
				C=card2bit[A];
				if(card[C] <= Kadd) {
					row[k]= (n-card[C])/(card[C]+1.)/(n-1.)  * wei;
					rowno[k]=RowsR + A;
					k++;
				}
			}
			k1=k;
			for(j=1;j<k1;j++) if(rowno[j]>RowsR+n) {
				row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
		// upper bound
		if(orness[1]<1) {
			row[0]= -orness[1] *wei; rowno[0]=0; k=1;
			for(A=1; A < m; A++){
				C=card2bit[A];
				if(card[C] <= Kadd) {
					row[k]= -(n-card[C])/(card[C]+1.)/(n-1.)*wei;
					rowno[k]=RowsR + A;
					k++;
				}
			}
			k1=k;
			for(j=1;j<k1;j++) if(rowno[j]>RowsR+n) {
				row[k]=-row[j]; rowno[k]=rowno[j]+RowsC1; k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
	}

	if(option1 & 0x2 ==0x2) { // balanced. Means there plenty of conditions of the same type as monotonicity constraints, but more of those
		// this is not yet implemented, reserved for future use
	}
	if((option1 & 0x4) == 0x4) { // presevation of output orderings. to reduce the number of conditions, sort the outputs in increasing order
		tempyk=new valindex[K];

		for(k=0;k<K;k++) { (tempyk[k]).v=XYData [k*(n+1)+n ]; (tempyk[k]).i=k;}
		sort(&(tempyk[0]),&(tempyk[K]),less_than1); // sorted in increasing order

		for(i1=0;i1<K-1;i1++) {
			i=(tempyk[i1]).i;
			j=(tempyk[i1+1]).i;// so the constraint involves j-th and i-th data
			 rowno[0]=0; row[0]=0; k=1;
			// now the vales of h_A
			for(k1=0;k1<n;k1++) {// singletons
				row[k]=XYData[j*(n+1)+k1] - XYData[i*(n+1)+k1];
				rowno[k] = RowsR + k;
				k++;
			}
			for(k1=0;k1<RowsC1;k1++) {
				row[k]=min_subset( &(XYData[j*(n+1)]), n, card2bit[k1 + n +1]) - min_subset( &(XYData[i*(n+1)]), n, card2bit[k1 + 1 + n]);
				rowno[k] = RowsR + k;

				row[k + RowsC1]= - row[k] ;
				rowno[k + RowsC1] = rowno[k]  + RowsC1;
				k++;
			}
			itemp = k+RowsC1;
			re=add_columnex(MyLP, itemp, row, rowno);		

		}
		delete [] tempyk;
	}


	int RR=get_Nrows(MyLP);
	int CC=get_Ncolumns(MyLP);
	for(i=1;i<=RR;i++) {
		set_rh(MyLP,i, 0 ); 
		set_constr_type(MyLP,i,LE);

	}
	for(i=1;i<=CC;i++) {
		set_bounds(MyLP, i, 0.0, 1.0);
	}

	for(i=1;i<=RowsR;i++) {
		set_rh(MyLP,i, 1.0 ); 
	}

	set_maxim(MyLP); // well, we always do that



	double *sol=(double*)malloc(sizeof(double)*(1 + RR + CC));

//	 write_lp(MyLP, "model.lp");
//	cout<<"finished building LP "<< RR<< " " <<CC<<endl;
//	set_outputfile(MyLP, "log.txt");
//	print_lp(MyLP);

  set_verbose(MyLP,0);

	res=solve(MyLP);
	double minval,rp,rm;

	if(res==OPTIMAL) {
		temp=0;
		get_dual_solution(MyLP, sol);

		minval = get_objective(MyLP) ;  // minimum

		for(i=1;i<=K;i++)
		{
			rp= sol[i]; // residuals
			rm= sol[i+K];
//			temp += (rp+rm);
		}
//cout<<" min value "<<minval<<" "<<temp<<endl;

		v[0]=0;// always !!
		for(i=1; i<=n; i++)
		{
			v[i]= sol[i+RowsR]; // singletons
		}
		for(i=0; i<RowsC1; i++) 
		{
			v[i+n+1]= sol[n+RowsR+1+i] - sol[n+RowsR+1 + RowsC1+i]; // other subsets
			k++;
		}
		k=n+RowsC1+1; 
		for(i=k;i<m;i++) v[i]=0; // all other values of f.m. are 0
		result=1;
	} // no optimal
	else result=0;

	free (sol);
	delete_lp(MyLP);
	return result;
}


int	FuzzyMeasureFitLPsymmetric(int n,  int K, double *v, double* XYData, int options, 
			double* indexlow, double* indexhigh, int option1, double* orness )
 //this is just an OWA, treat it explicitly
 // if options==1 the it will be WAM

{
  int i,j,k,k1,res,i1;
  int result;
  unsigned int A,B,C;
  lprec		*MyLP;
  int RowsR,RowsC, RowsC1;
  int ColsR, ColsC;
  valindex *tempyk;
  double temp;

// calculate how many rows/columns we need

  RowsC1	= 0;
  RowsR=K*2; RowsC = n + RowsC1*2;

  ColsR = RowsR;
  ColsC=0; // unknow at this stage

  MyLP = make_lp( RowsR+RowsC, 0);
  MyLP->do_presolve=FALSE;   
  set_verbose(MyLP,3);
  int itemp = RowsC+2 +1; // just the max number of entries per column

  double *row;
  int	 *rowno;
  row=new double[itemp];
  rowno=new int[itemp];
  int re;

// the first K columns
  rowno[0]=0;
  for(k=0;k<K; k++) { 
	    //rowno[0] is the obj. function
	    row[0] = XYData [k*(n+1)+n ];//y[k]; //
		rowno[1]=k+1;  // 1-based
		rowno[2]=k+1+ K;
		row[1]=-1; 
		row[2]= 1;
// now the vales of h_A

		for(i=0;i<n;i++) { (tempxi[i]).v=XYData[k*(n+1)+i]; (tempxi[i]).i=i;}
		if(!(options==1))  {
			 sort(&(tempxi[0]),&(tempxi[n]),less_than1); // sorted in increasing order

			for(i=0;i<n;i++) {// singletons
				row[2+i+1]=    tempxi[n-i-1].v;
				rowno[2+i+1] = RowsR +i +1;
			}
		} 
		// else it will be a mean simply
		else 
			for(i=0;i<n;i++) {// singletons
				row[2+i+1]=    tempxi[i].v;
				rowno[2+i+1] = RowsR +i +1;
			}


		re=add_columnex(MyLP, itemp, row, rowno);

// now repeat everything, just change the sign
		for(i=0;i<itemp;i++) row[i]=-row[i];

		re=add_columnex(MyLP, itemp, row, rowno);
  }

  // next equality constraint = add to 1
  double wei=K; // this constraint is taken with that weight, to ensure it is actually satisfied 
  if(wei<1) wei=1;
  // despite roundoff errors 
  row[0]=wei; rowno[0]=0; k=1;
  for(i=0;i<RowsC1+n;i++) {
	  row[k]=wei;
	  rowno[k]= i+ RowsR+1;
	  k++;
  }

	re=add_columnex(MyLP, k, row, rowno);
// now reverse inequality
    for(i=0;i<k;i++) row[i]=-row[i];
	re=add_columnex(MyLP, k, row, rowno);



	// additional options:
	// bit 1 = specified orness value
	// bit 2 = add condition that f.m. is balanced
	// bit 3 = add condition of preservation of output orderings
	// bit 4 - submodular 
//	wei/=2.;
	if((option1 & 0x1) == 0x1) { // orness specified orness[0]=lower bound, orness[1]=upper bound
		if(orness[0]>0) {
			row[0]=orness[0] * wei; rowno[0]=0; k=1;
			for(i=0;i<n;i++) {
				rowno[k]=RowsR+i+1;
				row[k]=(n-(i+1.0))/(n-1.0) *wei;
				k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
		// upper bound
		if(orness[1]<1) {
			row[0]= -orness[1] *wei; rowno[0]=0; k=1;
			for(i=0;i<n;i++) {
				rowno[k]=RowsR+i+1;
				row[k]=-(n-(i+1.0))/(n-1.0) *wei;
				k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
	}

	if((option1 & 0x8) == 0x8) { // submodular
			row[0]=0; rowno[0]=0; 
			for(i=0;i<n-1;i++) {
				k=1;
				rowno[k]=RowsR+i+1;
				row[k]=wei;
				k++;
				rowno[k]=RowsR+i+1+1;
				row[k]=-wei;
				k++;
				re=add_columnex(MyLP, k, row, rowno);
		}

	}

	if(option1 & 0x2 ==0x2) { // balanced. Means there plenty of conditions of the same type as monotonicity constraints, but more of those
		// this is not yet implemented, reserved for future use
	}
	if((option1 & 0x4) == 0x4) { // presevation of output orderings. to reduce the number of conditions, sort the outputs in increasing order
		tempyk=new valindex[K];

		for(k=0;k<K;k++) { (tempyk[k]).v=XYData [k*(n+1)+n ]; (tempyk[k]).i=k;}
		sort(&(tempyk[0]),&(tempyk[K]),less_than1); // sorted in increasing order

		for(i1=0;i1<K-1;i1++) {
			i=(tempyk[i1]).i;
			j=(tempyk[i1+1]).i;// so the constraint involves j-th and i-th data
			 rowno[0]=0; row[0]=0; k=1;
			// now the vales of h_A
			for(k1=0;k1<n;k1++) {// singletons
				row[k]=XYData[j*(n+1)+k1] - XYData[i*(n+1)+k1];
				rowno[k] = RowsR + k;
				k++;
			}
			itemp = k+RowsC1;
			re=add_columnex(MyLP, itemp, row, rowno);		

		}
		delete [] tempyk;
	}


	int RR=get_Nrows(MyLP);
	int CC=get_Ncolumns(MyLP);
	for(i=1;i<=RR;i++) {
		set_rh(MyLP,i, 0 ); 
		set_constr_type(MyLP,i,LE);

	}
	for(i=1;i<=CC;i++) {
		set_bounds(MyLP, i, 0.0, 1.0);
	}

	for(i=1;i<=RowsR;i++) {
		set_rh(MyLP,i, 1.0 ); 
	}

	set_maxim(MyLP); // well, we always do that



	double *sol=(double*)malloc(sizeof(double)*(1 + RR + CC));

//	 write_lp(MyLP, "model.lp");
//	cout<<"finished building LP "<< RR<< " " <<CC<<endl;
//	set_outputfile(MyLP, "log.txt");
//	print_lp(MyLP);

  set_verbose(MyLP,0);

	res=solve(MyLP);
	double minval,rp,rm;

	if(res==OPTIMAL) {
		temp=0;
		get_dual_solution(MyLP, sol);

		minval = get_objective(MyLP) ;  // minimum

		for(i=1;i<=K;i++)
		{
			rp= sol[i]; // residuals
			rm= sol[i+K];
//			temp += (rp+rm);
		}
//cout<<" min value "<<minval<<" "<<temp<<endl;


		for(i=1; i<=n; i++)
		{
			v[i-1]= sol[i+RowsR]; // singletons
		}
		result=1;
	} // no optimal
	else result=0;

	free (sol);
	delete_lp(MyLP);
	return result;
}
int	FuzzyMeasureFitLPsymmetricinterval(int n,  int K, double *v, double* XYData, int options, 
			double* indexlow, double* indexhigh, int option1, double* orness )
 //this is just an OWA, treat it explicitly

{
  int i,j,k,k1,res,i1;
  int result;
  unsigned int A,B,C;
  lprec		*MyLP;
  int RowsR,RowsC, RowsC1;
  int ColsR, ColsC;
  valindex *tempyk;
  double temp;

// calculate how many rows/columns we need

  RowsC1	= 0;
  RowsR=K*2; RowsC = n + RowsC1*2;

  ColsR = RowsR;
  ColsC=0; // unknow at this stage

  MyLP = make_lp( RowsR+RowsC, 0);
  MyLP->do_presolve=FALSE;   
  set_verbose(MyLP,3);
  int itemp = RowsC+1 +1; // just the max number of entries per column

  double *row;
  int	 *rowno;
  row=new double[itemp];
  rowno=new int[itemp];
  int re;

// the first K columns
  rowno[0]=0;
  for(k=0;k<K; k++) { 
	    //rowno[0] is the obj. function
	    row[0] = XYData [k*(n+2)+n ];//y[k]; //
		rowno[1]=k+1;  // 1-based
//		rowno[2]=k+1+ K;
		row[1]=-1; 
//		row[2]= 1;
// now the vales of h_A

		for(i=0;i<n;i++) { (tempxi[i]).v=XYData[k*(n+2)+i]; (tempxi[i]).i=i;}

		if(!(options==1))  {
			 sort(&(tempxi[0]),&(tempxi[n]),less_than1); // sorted in increasing order

			for(i=0;i<n;i++) {// singletons
				row[1+i+1]=    tempxi[n-i-1].v;
				rowno[1+i+1] = RowsR +i +1;
			}
		} 
		// else it will be a mean simply
		else 
			for(i=0;i<n;i++) {// singletons
				row[1+i+1]=    tempxi[i].v;
				rowno[1+i+1] = RowsR +i +1;
			}


		re=add_columnex(MyLP, itemp, row, rowno);

// now repeat everything, just change the sign
		for(i=0;i<itemp;i++) row[i]=-row[i];
		rowno[1]=k+1+ K;
		row[1]=1;
	   row[0] = - XYData [k*(n+2)+n +1];//y[k]; // upper bound y-

		re=add_columnex(MyLP, itemp, row, rowno);
  }

  // next equality constraint = add to 1
  double wei=K; // this constraint is taken with that weight, to ensure it is actually satisfied 
  if(wei<1) wei=1;
  // despite roundoff errors 
  row[0]=wei; rowno[0]=0; k=1;
  for(i=0;i<RowsC1+n;i++) {
	  row[k]=wei;
	  rowno[k]= i+ RowsR+1;
	  k++;
  }

	re=add_columnex(MyLP, k, row, rowno);
// now reverse inequality
    for(i=0;i<k;i++) row[i]=-row[i];
	re=add_columnex(MyLP, k, row, rowno);



	// additional options:
	// bit 1 = specified orness value
	// bit 2 = add condition that f.m. is balanced
	// bit 3 = add condition of preservation of output orderings
	// bit 4 - submodular 
//	wei/=2.;
	if((option1 & 0x1) == 0x1) { // orness specified orness[0]=lower bound, orness[1]=upper bound
		if(orness[0]>0) {
			row[0]=orness[0] * wei; rowno[0]=0; k=1;
			for(i=0;i<n;i++) {
				rowno[k]=RowsR+i+1;
				row[k]=(n-(i+1.0))/(n-1.0) *wei;
				k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
		// upper bound
		if(orness[1]<1) {
			row[0]= -orness[1] *wei; rowno[0]=0; k=1;
			for(i=0;i<n;i++) {
				rowno[k]=RowsR+i+1;
				row[k]=-(n-(i+1.0))/(n-1.0) *wei;
				k++;
			}
			re=add_columnex(MyLP, k, row, rowno);
		}
	}

	if((option1 & 0x8) == 0x8) { // submodular
			row[0]=0; rowno[0]=0; 
			for(i=0;i<n-1;i++) {
				k=1;
				rowno[k]=RowsR+i+1;
				row[k]=wei;
				k++;
				rowno[k]=RowsR+i+1+1;
				row[k]=-wei;
				k++;
				re=add_columnex(MyLP, k, row, rowno);
		}

	}

	if(option1 & 0x2 ==0x2) { // balanced. Means there plenty of conditions of the same type as monotonicity constraints, but more of those
		// this is not yet implemented, reserved for future use
	}
	if((option1 & 0x4) == 0x4) { // presevation of output orderings. to reduce the number of conditions, sort the outputs in increasing order
		tempyk=new valindex[K];

		for(k=0;k<K;k++) { (tempyk[k]).v=XYData [k*(n+2)+n ]; (tempyk[k]).i=k;}
		sort(&(tempyk[0]),&(tempyk[K]),less_than1); // sorted in increasing order

		for(i1=0;i1<K-1;i1++) {
			i=(tempyk[i1]).i;
			j=(tempyk[i1+1]).i;// so the constraint involves j-th and i-th data
			 rowno[0]=0; row[0]=0; k=1;
			// now the vales of h_A
			for(k1=0;k1<n;k1++) {// singletons
				row[k]=XYData[j*(n+2)+k1] - XYData[i*(n+2)+k1];
				rowno[k] = RowsR + k;
				k++;
			}
			itemp = k+RowsC1;
			re=add_columnex(MyLP, itemp, row, rowno);		

		}
		delete [] tempyk;
	}


	int RR=get_Nrows(MyLP);
	int CC=get_Ncolumns(MyLP);
	for(i=1;i<=RR;i++) {
		set_rh(MyLP,i, 0 ); 
		set_constr_type(MyLP,i,LE);

	}
	for(i=1;i<=CC;i++) {
		set_bounds(MyLP, i, 0.0, 1.0);
	}

	for(i=1;i<=RowsR;i++) {
		set_rh(MyLP,i, 1.0 ); 
	}

	set_maxim(MyLP); // well, we always do that



	double *sol=(double*)malloc(sizeof(double)*(1 + RR + CC));

//	 write_lp(MyLP, "model.lp");
//	cout<<"finished building LP "<< RR<< " " <<CC<<endl;
//	set_outputfile(MyLP, "log.txt");
//	print_lp(MyLP);

  set_verbose(MyLP,0);

	res=solve(MyLP);
	double minval,rp,rm;

	if(res==OPTIMAL) {
		temp=0;
		get_dual_solution(MyLP, sol);

		minval = get_objective(MyLP) ;  // minimum

		for(i=1;i<=K;i++)
		{
			rp= sol[i]; // residuals
			rm= sol[i+K];
//			temp += (rp+rm);
		}
//cout<<" min value "<<minval<<" "<<temp<<endl;


		for(i=1; i<=n; i++)
		{
			v[i-1]= sol[i+RowsR]; // singletons
		}
		result=1;
	} // no optimal
	else result=0;

	free (sol);
	delete_lp(MyLP);
	return result;
}

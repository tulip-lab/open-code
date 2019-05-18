/********************* Fuzzy measure toolkit ******************************************

This is a set of useful routines for manipulations with fuzzy measures 
(and other set functions). They include binary encoding of a discrete set 
(as  integers (up to 32 elements in a set)), simple set operations: 
intersection, union, inclusion, difference, etc. various representations of 
fuzzy measures (standard, Moebius), orderings of their values, conversions, 
calculations of Shapley, Banzhaf and other interaction indices, orness, entropy, etc.
Calculation of Choquet and Sugeno integrals for a given input x.

--------------------------------------------------------------------------------------
 *
 *      begin                : May 10 2007
 *              version                          : 1.0 
 *              copyright            : (C) 2007 by Gleb Beliakov
 *              email                : gleb@deakin.edu.au
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

#define tolerance 0.00001

struct valindex {
        double v;
        int i;
};
struct Less_than {  
  bool operator()(const valindex& a, const valindex& b) { return a.v < b.v;  }
  };
struct Greater_than {  
  bool operator()(const valindex& a, const valindex& b) {  return a.v > b.v;  }
  };

 
extern valindex tempxi[100];

extern double   *m_factorials;  // keeps factorials  n! up to n
extern int              *card;                  // array to keep set cardinalities in binary ordering
extern int *cardpos;   // array to store the indices of elements of different cardinalities in the cardinality ordering

extern unsigned int *bit2card; // arrays to transform from one ordering to another
extern unsigned int *card2bit;

// this routine should be called first to prepare all the arrays
void Preparations_FM(int n, unsigned int *m);
// this routine should be called last to clean all the arrays
void Cleanup_FM();


/* useful routines */
extern double   minf(double a, double b); 
double  maxf(double a, double b);
int             sign(int i);   // sign of i
int             IsOdd(int i);  // is i odd ?
unsigned int cardf(unsigned int i); // count how many bits in i are set
double xlogx(double t);         // x log x (but takes care of x close to 0, using tolerance parameter

/* Set manipulations. A set is represented by an unsigned int (32 bits) */
void    RemoveFromSet(unsigned int* A, int i);  // remove a from set i
void    AddToSet(unsigned int* A, int i);               // add a to set i
int             IsInSet(unsigned int A, int i);                 // does a belong to set i?
int             IsSubset(unsigned int A, unsigned int B);       // is j subset of i ?
unsigned int  Setunion(unsigned int A, unsigned int B); // returns the  union of sets i and j
unsigned int  Setintersection(unsigned int A, unsigned int B); // returns the  intersection of sets i and j
unsigned int  Setdiff(unsigned int A, unsigned int B);                  // returns set difference  i \ j
double min_subset(double* x, int n, unsigned int S); // returns minimum of x_i, such that i belongs to set S

int     ShowValue(unsigned int s); // shows the elements of a subset as a decimal string (up to 10 elements)

double Choquet(double*x, double* v, int n, unsigned int m);
/* Calculates the value of a descrete Choquet integral of x, wrt fuzzy measure v 
Parameters: x array[n] ,v array[m], n, m=2^n 
This proceduce requires sorting the array of pairs (v[i],i) in non-decreasing order
(perfored by standard STL sort function, and RemoveFromSet() function, to remove
an indicated bit from a set (in its binary representation)
*/
double ChoquetMob(double*x, double* Mob, int n, unsigned int m);
/*This is an alternative calculation of the Choquet integral from the Moebius transform v
 it is not as efficient as Choquet(). Provided for testing purposes */

double Sugeno(double*x, double* v, int n,unsigned int m);
/* Calculates the value of a descrete Sugeno integral of x, wrt fuzzy measure v 
Parameters: x array[n] ,v array[m], n, m=2^n 
This proceduce requires sorting the array of pairs (v[i],i) in non-decreasing order
(perfored by standard STL sort function, and RemoveFromSet() function, to remove
an indicated bit from a set (in its binary representation)
Also requires maxf and minf functions.
*/

double OWA(double*x, double* v, int n );
/* Calculates the value of OWA */
double WAM(double*x, double* v, int n );
/* Calculates the value of WAM */

void ConstructLambdaMeasure(double *singletons, double *lambda, double *v, int n,unsigned int m);
/* Given the values of the fuzzy measure at singletons, finds the appropriate
lambda, and constructs the rest of the fuzzy measure. Returns lambda and v at the output
*/
/* ---------------Operations on fuzzy measures -------------------------*/
double Orness(double* Mob,  int n,unsigned int m); // calculates orness value of a fuzzy measure
double Entropy(double* v,  int n,unsigned int m);// calculates Entropy  of a fuzzy measure


double OrnessOWA(double* w,  int n); // calculates orness value of a fuzzy measure

void Mobius(double* v, double* Mob, int n,unsigned int m); // calculates Moebius representation of v
/* the output array w should ave the same size 2^n=m as v */
void Zeta(double* Mob, double* v, int n, unsigned int m);// calculates inverse Moebius transform

void Shapley(double* v, double* x, int n,unsigned int m); // calculates the array x of Shapley values
void Banzhaf(double* v, double* x, int n,unsigned int m);// calculates the array x of Banzhaf indices
void Interaction(double* Mob, double* w,unsigned int m); // calculates all 2^n interaction indices (returned in w)
void InteractionB(double* Mob, double* w,unsigned int m); // calculates all 2^n Banzhaf interaction indices (returned in w)

void dualm(double* v, double* w, int n,unsigned int m); // calculates the dual fuzzy measure, returns it in w

// various queries about a fuzzy measure. All performed with a given tolerance
int IsMeasureBalanced(double* v,unsigned int m);
int IsMeasuresubadditive(double* v,unsigned int m);
int IsMeasuresuperadditive(double* v,unsigned int m);
int IsMeasuresupermodular(double* v,unsigned int m);
int IsMeasuresubmodular(double* v,unsigned int m);
int IsMeasureadditive(double* v, int n,unsigned int m);
int IsMeasuresymmetric(double* v, int n,unsigned int m);
int IsMeasureselfdual(double* v,unsigned int m);

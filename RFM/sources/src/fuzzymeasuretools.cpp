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

#include <iostream>
#include <fstream>
#include <cmath>
#include <algorithm>
#include <R.h>
#include "fuzzymeasuretools.h"
using namespace std;

  Less_than less_than;              /* declare a comparison function object, to */
  Greater_than  greater_than ;      /*  pass to sort and search algorithms */

 valindex tempxi[100];
 double         *m_factorials;  // keeps factorials  n! up to n
 int            *card;                  // array to keep set cardinalities in binary ordering
 int            *cardpos;   // array to store the indices of elements of different cardinalities in the cardinality ordering

 unsigned int *bit2card;        // arrays to transform from one ordering to another
 unsigned int *card2bit;

int sign(int i) {if(i<0) return -1; else return 1;}
int signd(double i) {if(i<0) return -1; else return 1;}
typedef double ( *USER_FUNCTION)(double );
double bisection(double a, double b, USER_FUNCTION f, int nmax)
{
        double u,v,c,w;
        int i;
        u=f(a); v=f(b);
        if(signd(u)==signd(v)) { return -10e10;} // no solution
        i=nmax;
        while(i>0) {
                i--;
                c=(a+b)/2.0;
                w=f(c);
                if( (b-a) < 1.0e-10 ) break;
                if(signd(u)==signd(w)) {
                        u=w; a=c;
                } else {
                        v=w;b=c;
                }
        }
        return (a+b)/2.0;
}


double minf(double a, double b) {if (a<b) return a; else return b;}
double maxf(double a, double b) {if (a>b) return a; else return b;}

int IsOdd(int i) {return ((i & 0x1)?1:0); }
unsigned int cardf(unsigned int A) // count how many bits in i are set
{
        int s=0;
        unsigned int t=A;
                while(t>0) {
                        if(t & 0x1) s++;
                        t=(t>>1);
                }
        return s;
}


double xlogx(double t) { if(t<tolerance) return 0; else return t*log(t);} 

void RemoveFromSet(unsigned int* A, int i) { *A &= (~(1<<i));   }
void AddToSet(unsigned int* A, int i) {*A |= (1 << i);}
int  IsInSet(unsigned int A, int i) {   return ((A>>i) & 0x1);  }
int  IsSubset(unsigned int A, unsigned int B) { return ((A & B)==B);    }
unsigned int Setunion(unsigned int A, unsigned int B) {return (A |B); }
unsigned int Setintersection(unsigned int A, unsigned int B) {return (A & B); }
unsigned int Setdiff(unsigned int A, unsigned int B) { return (A & ~( A & B) ); }


int     ShowValue(unsigned int s) {
                int i,j,k;
                k=0;
                j=0;
                for(i=0;i<10;i++) {
                        if(IsInSet(s,i)) {
                                k *= 10;
                                k += (i+1);
                        }
                }
                return k;
}

double Choquet(double*x, double* v, int n, unsigned int m)
/* Calculates the value of a discrete Choquet integral of x, wrt fuzzy measure v 
Parameters: x array[n] ,v array[m], n, m=2^n 
This proceduce requires sorting the array of pairs (v[i],i) in non-decreasing order
(perfored by standard STL sort function, and RemoveFromSet() function, to remove
an indicated bit from a set (in its binary representation) */
{       double s=0;
        int i;
        for(i=0;i<n;i++) { (tempxi[i]).v=x[i]; (tempxi[i]).i=i;}
        sort(&(tempxi[0]),&(tempxi[n]),less_than); // sorted in increasing order

        unsigned int id = m-1; // full set N (11111... in binary)

        s=tempxi[0].v*v[id];
        RemoveFromSet(&id, tempxi[0].i);
        for(i=1;i<n;i++) {
                s+=(tempxi[i].v - tempxi[i-1].v)* v[id];
                RemoveFromSet(&id, tempxi[i].i);
        }
        return s;
}




double ChoquetMob(double*x, double* Mob, int n, unsigned int m)
/*This is an alternative calculation of the Choquet integral from the Moebius transform
 it is not as efficient as Choquet(). Provided for testing purposes */
{       double s=0;
        unsigned int A;
        for(A=1; A< m; A++)
                s+= Mob[A] * min_subset( x, n, A) ;
        return s;
}



double Sugeno(double*x, double* v, int n, unsigned int m)
{
/* Calculates the value of a discrete Sugeno integral of x, wrt fuzzy measure v 
Parameters: x array[n] ,v array[m], n, m=2^n 
This proceduce requires sorting the array of pairs (v[i],i) in non-decreasing order
(perfored by standard STL sort function, and RemoveFromSet() function, to remove
an indicated bit from a set (in its binary representation)
Also requires maxf and minf functions. */
        double s=0;
        int i;
        for(i=0;i<n;i++) { (tempxi[i]).v=x[i]; (tempxi[i]).i=i;}
        sort(&(tempxi[0]),&(tempxi[n]),less_than); // sorted in decreasing order

        unsigned int id = m-1; // full set N (11111... in binary)

        s=0;
        for(i=0;i<n;i++) {
                s =maxf(s, minf(tempxi[i].v , v[id]));
                RemoveFromSet(&id, tempxi[i].i);
        }
        return s;
}


double OWA(double*x, double* v, int n )
/* Calculates the value of an OWA 
Parameters: x array[n] ,v array[n], n, 
This proceduce requires sorting the array of pairs (v[i],i) in non-decreasing order
 */
{       double s=0;
        int i;
        for(i=0;i<n;i++) { (tempxi[i]).v=x[i]; (tempxi[i]).i=i;}
        sort(&(tempxi[0]),&(tempxi[n]),less_than); // sorted in increasing order

        for(i=0;i<n;i++) {
                s+=  tempxi[n-i-1].v * v[i];
        }
        return s;
}
double WAM(double*x, double* v, int n )
/* Calculates the value of a WAM 
Parameters: x array[n] ,v array[n], n, 
 */
{       double s=0;
        int i;
        for(i=0;i<n;i++) {
                s+=  x[i] * v[i];
        }
        return s;
}


double auxarray[100];
int auxN;
double auxfun(double lam)
{
        int i;
        double s=1;
        for(i=0;i<auxN;i++) s*= (1 + lam* auxarray[i]);
        s -= (lam+1);
        return s;
}
void ConstructLambdaMeasure(double *singletons, double *lambda, double *v, int n,unsigned int m)
/* Given the values of the fuzzy measure at singletons, finds the appropriate
lambda, and constructs the rest of the fuzzy measure. Returns lambda and v at the output
*/
{
        double tol=1.0e-8;
        int i;
        auxN=n;
        for(i=0;i<n;i++) auxarray[i]=singletons[i];
        
        double a,b,c;
        a=-1+tol;
        b=0-tol;
        c=bisection(a,b,auxfun,10000);
        if(c<-1) { //means we have to use another interval
                a=tol;
            b=10000;
                c=bisection(a,b,auxfun,100000);
        }
        // so lambda is c now
        unsigned int j;
        double s;
        v[0]=0;
        for(j=1;j<m;j++) {
                s=1;
                for(i=0;i<n;i++) if(IsInSet(j, i)) 
                        s *= (1+ c* auxarray[i]);
                s = (s-1)/c;
                v[j]=s;
        }
        *lambda=c;
        
}

double Orness(double* Mob,  int n, unsigned int m)
{
        unsigned int i;
        double s;
        s=0;
        for(i=1;i<m;i++) { 
                s += Mob[i] * (n-card[i])/(card[i]+1.);
        }
        return s/(n-1);
}

double OrnessOWA(double* w,  int n)
{
        unsigned int i;
        double s;
        s=0;
        for(i=1;i<=n;i++) { 
                s += w[i-1] * (n-i+0.0)/(n-1.);
        }
        return s;
}

double Entropy(double* v,  int n, unsigned int m)
{
        int i;
        unsigned int id,tempid;
        double s=0;
        double nfac=m_factorials[n];
        for(i=0;i<n;i++) {
                tempid=0;       AddToSet(&tempid,i);
                for(id=0;id<m;id++) if(!IsInSet(id,i)) { 
                        s += -xlogx(v[ Setunion(id,tempid) ] - v[id]) * m_factorials[n-card[id]-1]*m_factorials[card[id]]/nfac;
                }
        }
        return s;
}

void Mobius(double* v, double* Mob, int n, unsigned int m)
{
        unsigned int i,id;
        double s;
        for(i=0;i<m;i++) {
                s=0;
                for(id=0;id <= i;id++) if(IsSubset(i,id)) {
                        s += v[id] * (IsOdd( card[Setdiff(i,id) ]) ? -1:1); ;
                }
                Mob[i]=s;
        }
}
void Zeta(double* Mob, double* v, int n, unsigned int m)
//inverse Moebius transform
{
        unsigned int i,id;
        double s;
        for(i=0;i<m;i++) {
                s=0;
                for(id=0;id <= i;id++) if(IsSubset(i,id)) {
                        s += Mob[id] ;
                }
                v[i]=s;
        }
}


void Shapley(double* v, double* x, int n, unsigned int m)
{
        int j;
        unsigned int i,id;

        for(j=0;j<n;j++) {
                id=0; AddToSet(&id, j); 
                x[j]=0;
                for(i=0;i<m;i++) 
                        if(!IsInSet(i,j)) {
                                x[j] += (m_factorials[n-card[i]-1]*m_factorials[card[i]])/m_factorials[n] *
                                        ( v[ Setunion(i,id) ] - v[i]);
                        }
        }
}

void Banzhaf(double* v, double* x, int n, unsigned int m)
{
        int j;
        unsigned int i,id;

        for(j=0;j<n;j++) {
                id=0; AddToSet(&id, j); 
                x[j]=0;
                for(i=0;i<m;i++) 
                        if(!IsInSet(i,j)) {
                                x[j] +=  (v[ Setunion(i,id) ] - v[i]);
                        }
                x[j] /= (1<<(n-1));
        }
}


void Interaction(double* Mob, double* w, unsigned int m)
{
        unsigned int j,i,id;
        for(i=0;i<m;i++) {
                w[i]=0;
                j=card[i];
                for(id=i;id<m;id++) // supersets only
                        if(IsSubset(id,i))
                                w[i]+=Mob[id]/( card[id]- j +1);
        }
}

void InteractionB(double* Mob, double* w, unsigned int m)
{
        unsigned int j,i,id;
        for(i=0;i<m;i++) {
                w[i]=0;
                j=card[i];
                for(id=i;id<m;id++) // supersets only
                        if(IsSubset(id,i))
                                w[i]+=Mob[id]/ (1<<( card[id]- j ));
        }
}

void dualm(double* v, double* w, int n, unsigned int m)
{
        unsigned int i;
        for(i=0;i<m;i++)
        {
                w[ (~i) & (m-1) ] = 1-v[i];
        }
}


int IsMeasureBalanced(double* v, unsigned int m)
{
        unsigned int i,j;
        for(i=0;i<m;i++) {
                for(j=i;j<m;j++) {
                        if((card[i]<card[j]) && (v[i]>v[j])) return 0;
                        if((card[i]>card[j]) && (v[i]<v[j])) return 0;
                }
        }
        return 1;
}
int IsMeasuresubadditive(double* v, unsigned int m)
{
        unsigned int i,j;
        for(i=0;i<m;i++) {
                for(j=i+1;j<m;j++) if(Setintersection(i,j)==0) {
                        if(v[i]+v[j] - v[Setunion(i,j)] < -tolerance) return 0;
                }
        }
        return 1;
}

int IsMeasuresuperadditive(double* v, unsigned int m)
{
        unsigned int i,j;
        for(i=0;i<m;i++) {
                for(j=i+1;j<m;j++) if(Setintersection(i,j)==0) {
                        if(v[i]+v[j] - v[Setunion(i,j)] > tolerance) return 0;
                }
        }
        return 1;
}

int IsMeasuresupermodular(double* v, unsigned int m)
{
        unsigned int i,j;
        for(i=0;i<m;i++) {
                for(j=i+1;j<m;j++) {
                        if(v[i]+v[j] - v[Setunion(i,j)] - v[Setintersection(i,j)] > tolerance) return 0;
                }
        }
        return 1;
}
int IsMeasuresubmodular(double* v, unsigned int m)
{
        unsigned int i,j;
        for(i=0;i<m;i++) {
                for(j=i+1;j<m;j++) if(Setintersection(i,j)==0) {
                        if(v[i]+v[j] - v[Setunion(i,j)]- v[Setintersection(i,j)] < -tolerance) return 0;
                }
        }
        return 1;

}
int IsMeasureadditive(double* v,  int n, unsigned int m)
{       
        int j;
        unsigned int i;
        double s;
        for(i=3;i<m;i++) {
                if(card[i]>1) {
                        s=0;
                        for(j=0;j<n;j++)
                         if(IsInSet(i,j)) s+=v[ 1<<j ];
                        if(fabs(s-v[i])>tolerance) return 0;
                }
        }
        return 1;
}
int IsMeasuresymmetric(double* v, int n, unsigned int m)
{
        unsigned int i,j;
        double *w=new double[n];
        for(i=0;i<(unsigned int)n;i++) w[i]=-1;

        for(i=0;i<m;i++) {
                j=card[i];
                if(w[j]<0) w[j]=v[i]; else
                        if(fabs(w[j]-v[i])>tolerance) {delete[] w; return 0; }
        }
        delete[] w;
        return 1;
}
int IsMeasureselfdual(double* v,unsigned int m)
{       
        unsigned int i;
        for(i=0;i<m;i++)
        {
                if(fabs(v[ (~i) & (m-1) ] + v[i]-1) > tolerance) return 0;
        }
        return 1;
}

double min_subset(double* x, int n, unsigned int S)
{ // returns min x_i when i \in S, or 0 if S is empty
        int i;
        double r=10e10;
        for(i=0;i<n;i++)
                if( IsInSet(S,i)) r=minf(r,x[i]);
        if(r>1) r=0;
        return r;
}

// this is a recursive procedure which helps build all subsets of a given cardinality, and 
// set up conversion arrays
void recursive_card(unsigned int* k, unsigned int level, unsigned int maxlevel, 
                                        unsigned int start, unsigned int finish,
                                        unsigned int* b2c, unsigned int* c2b, unsigned int *s, int n)
{
        unsigned int i1;
        for(i1=start; i1 <= finish; i1++) { AddToSet(s,i1);
                if(level == maxlevel) {
                        b2c[*s]=*k;
                        c2b[*k]=*s;
                        (*k)++;
                } else {
                        recursive_card(k,level+1,maxlevel,i1+1,finish+1,b2c,c2b,s,n);
                }
                RemoveFromSet(s,i1);
        }
}
void main_card(unsigned int* k, unsigned int level, unsigned int* b2c, unsigned int* c2b, int n)
{
        // we recursively construct all subsets of cardinality "level"
        unsigned int s=0;
        recursive_card(k,1,level,0, n-level, b2c,c2b, &s,n);
}



void Preparations_FM(int n, unsigned int *m)
{
        int i;
        unsigned int j;
        *m= 1<<(n);

// calculate the array containing factorials of i! (faster than calculating them every time)
    m_factorials=new double[n+1];
        m_factorials[0]=1;
        for(i=1;i<=n;i++) m_factorials[i] = m_factorials[i-1]*i;

// this array will contains cardinailities of subsets (coded as binaries), i.e. the number of bits in i.
        card=new int[(int) *m];
        cardpos=new int[n+1];
        card[0]=0;
        for(j=1;j<*m;j++) card[j] = cardf(j);

// these two arrays are used to pass from binary to cardinality ordering
// they are precomputed 
// in binary ordering the subsets are ordered as
// 0 1 2 12 3 13 23 123 4 14 24 124 34 134 234 1234,...
// (which corresponds to the order 0,1,2,3,... in binary form)
// in cardinality ordering they are ordered as
// 0 1 2 3 4 5 6 12 13 14 15 16 23 24 25 26 34 35 36 45 46 56 123 124,...
// (empty, singletons, pairs,triples, etc.)
// for a given subset s in cardinality ordering, to find its binary code use  card2bit[s]
// and vice versa
// cardpos[i] is the index at which subsets with cardinality i+1 start in the cardinality ordering
// i.e. cardpos[0]..cardpos[1]-1 - singletons, cardpos[1]..cardpos[2]-1 - pairs, etc.

        bit2card=new unsigned int[*m];
        card2bit=new unsigned int[*m];

        unsigned int k; int l;
        bit2card[0]=card2bit[0]=0;

        cardpos[0]=1; // positions where singletons start, the 0th element is empyset

        k=1;
        for(l=1;l<=n-1;l++) {
                main_card(&k, l, bit2card, card2bit,  n);
                cardpos[l]=k;
        }
        cardpos[n]=cardpos[n-1]+1;
        
        bit2card[*m-1]=card2bit[*m-1]=*m-1;
}
void Cleanup_FM()
{
        delete [] card2bit;
        delete [] bit2card;

        delete [] m_factorials;
        delete [] card;
        delete [] cardpos;

}

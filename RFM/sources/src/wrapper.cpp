#include <R.h>
#include "fuzzymeasuretools.h"
#include "fuzzymeasurefit.h"
extern "C" {

void fittingCall(int *n, int* datanum,int* Kadd, double *v, double *Dataset)
{
	double orness[2];
	orness[0]=0; 
	orness[1]=1;
	int res;
	int nn = *n;
	unsigned int m;
	int datanums = *datanum;
	int additive = *Kadd;

	Preparations_FM(nn,&m);

	double *w=new double[m];

	res = FuzzyMeasureFitLP(nn,  m,  datanums,  additive, w,  Dataset, 0, NULL , NULL, 0, orness);

	for(int i=0; i<m ; i++)  {
			v[card2bit[i]] = w[i];
	}

	Cleanup_FM();
	delete [] w;
}
void fittingOWACall(int *n, int* datanum, double *v, double *Dataset)
{
	double orness[2];
	orness[0]=0; 
	orness[1]=1;
	int res;
	int nn = *n;
	int datanums = *datanum;

	double *w=new double[nn];

	res = FuzzyMeasureFitLPsymmetricinterval(nn,  datanums, w,  Dataset, 0, NULL , NULL, 0, orness);
	
	for(int i=0; i<nn ; i++)  {
			v[i] = w[i];
	}
	
	delete [] w;
}	

void OWACall(double* x, double* v, int* n, double& owaval)
{
	int nn = *n;
	owaval  =  OWA(x,v,nn);
}


void fittingWAMCall(int *n, int* datanum, double *v, double *Dataset)
{
	double orness[2];
	orness[0]=0; 
	orness[1]=1;
	int res;
	int nn = *n;
	int datanums = *datanum;

	double *w=new double[nn];

	res = FuzzyMeasureFitLPsymmetric(nn,  datanums, w,  Dataset, 1, NULL , NULL, 0, orness);
	
	for(int i=0; i<nn ; i++)  {
			v[i] = w[i];
	}
	
	delete [] w;
}	


void WAMCall(double* x, double* v, int* n, double& wamval)
{
	int nn = *n;
	wamval  =  WAM(x,v,nn);
}

void ChoquetCall(double* x, double* v, int* n, double& cho)
{
	unsigned int m;
	int nn = *n;
    Preparations_FM(nn,&m);
	cho  = Choquet(x,v,nn,m);
	Cleanup_FM();
}

void ChoquetMobCall(double*x, double* Mob, int *n, double& choMob)
{
	unsigned int m;
	int nn = *n;
	Preparations_FM(nn,&m); 
    choMob = ChoquetMob(x, Mob, nn, m);
	Cleanup_FM();
}

void MobiusCall(double* v, double* MobVal, int *n)
{
	unsigned int m;
	int nn = *n;
	Preparations_FM(nn,&m);
	Mobius(v, MobVal,nn,m);	
	Cleanup_FM();
}


void ZetaCall(double* Mob, double* v, int *n)
{
	unsigned int m;
	int nn = *n;
	Preparations_FM(nn,&m);
	Zeta(Mob,v,nn,m);
	Cleanup_FM();
}

void ShapleyCall(double* v, double* x, int *n)
{
	unsigned int m;
	int nn = *n;
	Preparations_FM(nn,&m);
	Shapley(v, x,nn,m);	
	Cleanup_FM();
}
void InteractionCall(double* Mob, double* w, int *n, int* coliation)
{
	unsigned int m;
	int nn = *n;
	Preparations_FM(nn,&m);

	Interaction(Mob, w, m);	

	for(int i=0;i<m;i++)
	{
		 coliation[i] = ShowValue(i);
	}



	Cleanup_FM();
}	


}


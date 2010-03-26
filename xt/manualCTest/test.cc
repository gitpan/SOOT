#include <TROOT.h>
#include <TClassTable.h>
#include <TH1D.h>
#include <TPRegexp.h>
#include <TEnv.h>
#include <Rtypes.h>
#include <TClass.h>
#include <TMethod.h>
#include <Reflex/Scope.h>
#include <CallFunc.h>
#include <Class.h>
#include <TBaseClass.h>
#include <TList.h>
#include <TSystem.h>
#include <TApplication.h>
#include <TRandom.h>
#include <TBenchmark.h>
#include <TPad.h>
#include <TStyle.h>
#include <TDirectory.h>
#include <TCanvas.h>
#include <TVirtualPad.h>
#include <TPad.h>

#include <string>
#include <vector>
#include <iostream>
#include <iomanip>

using namespace std;

int main (int /*argc*/, char** /*argv*/) {
  gDebug = 1;
  gSystem->Load("libMathCore");
  gSystem->Load("libPhysics");
  gSystem->Load("libCore");
  int iCl = 0;
  while (iCl < gClassTable->Classes()) {
    const char* name = gClassTable->At(iCl++);
    TClass* c = TClass::GetClass(name);
  }

  gApplication = new TApplication("nbbb", NULL, NULL);

}


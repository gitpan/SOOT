use strict;
use warnings;
use SOOT ':all';

# This script illustrates the danger of using asymmetric symbols
# Non-symmetric symbols should be used carefully in plotting. 
# These two graphs show how misleading a careless use of symbols can be. 
# The two plots represent the same data sets but because of a bad symbol choice,
# the two plots on the top appear further apart than for the bottom example.
$gROOT->Reset;
$gStyle->SetOptStat(0);

my $Nph = 14;
my $np_ph  = [353.4,300.2,254.3,215.2,181.0,151.3,125.2,102.7, 83.3, 66.7, 52.5, 40.2, 30.2, 22.0];
my $nc_ph  = [3.890,3.734,3.592,3.453,3.342,3.247,3.151,3.047,2.965,2.858,2.701,2.599,2.486,2.328];
my $npe_ph = [10.068,9.004,8.086,7.304,6.620,6.026,5.504,5.054,4.666,4.334,4.050,3.804,3.604,3.440];
my $nce_ph = [0.235,0.217,0.210,0.206,0.213,0.223,0.239,0.260,0.283,0.318,0.356,0.405,0.465,0.545];

my $Nbr = 6;
my $np_br  = [357.0,306.0,239.0,168.0,114.0, 73.0];
my $nc_br  = [3.501,3.275,3.155,3.060,3.053,3.014];
my $npe_br = [8.000,11.000,10.000,9.000,9.000,8.000];
my $nce_br = [0.318,0.311,0.306,0.319,0.370,0.429];

my $phUP = TGraphErrors->new($Nph,$np_ph,$nc_ph,$npe_ph,$nce_ph);
my $phDN = TGraphErrors->new($Nph,$np_ph,$nc_ph,$npe_ph,$nce_ph);
my $brUP = TGraphErrors->new($Nbr,$np_br,$nc_br,$npe_br,$nce_br);
my $brDN = TGraphErrors->new($Nbr,$np_br,$nc_br,$npe_br,$nce_br);

my $Top_margin        = 0.;
my $Left_margin       = 0.025;
my $Right_margin      = 0.005;
my $maxPlotPart       = 395;
my $Marker_Size       = 1.3;
my $Marker_Style      = 8;

my $Et_200_Min        = 0.71;
my $Et_200_Max        = 3.80;
my $Et_130_Min        = 1.21;
my $Et_130_Max        = 3.29;

my $Nc_200_Min        = 1.31;
my $Nc_200_Max        = 4.30;
my $Nc_130_Min        = 1.51;
my $Nc_130_Max        = 3.89;


my $canvasNc = TCanvas->new("canvasNc", "Multiplicity",630,10,600,500);
$canvasNc->SetFillColor(10);
$canvasNc->SetBorderSize(0);
$canvasNc->SetLeftMargin(0.02);
$canvasNc->SetRightMargin(0.02);
$canvasNc->SetTopMargin(0.02);
$canvasNc->SetBottomMargin(0.02);


# ------------>Primitives in Nc200 pad
my $padNcUP = TPad->new("padNcUP","200 GeV",0.07,0.60,1.,1.00);
$padNcUP->Draw();
$padNcUP->cd();
$padNcUP->SetFillColor(10);
$padNcUP->SetFrameFillColor(10);
$padNcUP->SetBorderSize(0);
$padNcUP->SetLeftMargin($Left_margin);
$padNcUP->SetRightMargin($Right_margin);
$padNcUP->SetTopMargin($Top_margin+0.005);
$padNcUP->SetBottomMargin(0.00);

my $frameNcUP = TH1F->new("frameNcUP","",100,0,$maxPlotPart);
$frameNcUP->GetYaxis()->SetLabelOffset(0.005);
$frameNcUP->GetYaxis()->SetLabelSize(0.12);
$frameNcUP->SetMinimum($Nc_200_Min);
$frameNcUP->SetMaximum($Nc_200_Max);
$frameNcUP->SetNdivisions(505,"Y");
$frameNcUP->SetNdivisions(505,"X");
$frameNcUP->Draw();

$brUP->SetMarkerStyle(22);
$brUP->SetMarkerSize (2.0);
$brUP->Draw("P");                    

$phDN->SetMarkerStyle(23);
$phDN->SetMarkerSize (2);
$phDN->Draw("P");

$padNcUP->Modified();
$canvasNc->cd();

# ------------>Primitives in Nc130 pad
my $padNcDN = TPad->new("padNcDN","130 GeV",0.07,0.02,1.,0.60);
$padNcDN->Draw();
$padNcDN->cd();
$padNcDN->SetFillColor(10);
$padNcDN->SetFrameFillColor(10);
$padNcDN->SetBorderSize(0);
$padNcDN->SetLeftMargin($Left_margin);
$padNcDN->SetRightMargin($Right_margin);
$padNcDN->SetTopMargin($Top_margin+0.005);
$padNcDN->SetBottomMargin(0.30);

my $frameNcDN = TH1F->new("frameNcDN","",100,0,$maxPlotPart);
$frameNcDN->GetYaxis()->SetLabelOffset(0.005);
$frameNcDN->GetYaxis()->SetLabelSize(0.07);
$frameNcDN->GetXaxis()->SetLabelOffset(0.005);
$frameNcDN->GetXaxis()->SetLabelSize(0.07);
$frameNcDN->SetMinimum($Nc_200_Min);
$frameNcDN->SetMaximum($Nc_200_Max);
$frameNcDN->SetNdivisions(505,"Y");
$frameNcDN->SetNdivisions(505,"X");
$frameNcDN->Draw();

$brDN->SetMarkerStyle(23);
$brDN->SetMarkerSize (2.0);
$brDN->Draw("P");                    
           
$phUP->SetMarkerStyle(22);
$phUP->SetMarkerSize (2);
$phUP->Draw("P");

my $t1 = TLatex->new();
$t1->SetTextFont(12); 
$t1->SetTextSize(0.0525);
$t1->DrawLatex(-5,0.6,"Non-symmetric symbols should be used carefully in plotting. These two graphs show how misleading");
$t1->DrawLatex(-5,0.4,"a careless use of symbols can be. The two plots represent the same data sets but because of a bad");
$t1->DrawLatex(-5,0.2,"symbol choice, the two plots on the top appear further apart than for the bottom example.");

$padNcDN->Modified();
$canvasNc->cd();

$canvasNc->Modified();
$canvasNc->cd();

$gApplication->Run;


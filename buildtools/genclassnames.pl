use strict;
use warnings;
use File::Spec;

open my $h_oh, '>', File::Spec->catfile('src', 'SOOTClassnames.h') or die $!;
open my $cc_oh, '>', File::Spec->catfile('src', 'SOOTClassnames.cc') or die $!;

# These don't have dictionaries...
my %knownBadClasses = map {($_=>1)} qw(
  TDSet
  TGLBoundingBox
  TGLCamera
  TGLContext
  TGLFormat
  TGenCollectionStreamer
  TTreeFormula
  TVirtualRefProxy
);

# hack...
my %classes = map {($_=>1)} qw(
  ROOT::Fit::FitResult
);
open my $fh, '<', File::Spec->catfile('buildtools', 'caps') or die $!;
while (<$fh>) {
  m{
      ^\s*
      //\s*
      -*\s*
      (?:Begin|End)?\s*
      (\S+)
      \s*$
  }x or next;
  my $className = $1;
  next if exists $knownBadClasses{$className};
  ++$classes{$className};
}
close $fh;
my $nClassNames = keys %classes;

print $h_oh <<HERE;
#ifndef __soot_classnames_h_
#define __soot_classnames_h_

namespace SOOT {
  extern const unsigned int gNClassNames;
  extern const char* gClassNames[$nClassNames];
} // end namespace SOOT
#endif
HERE

print $cc_oh <<HERE;
#include "SOOTClassnames.h"

namespace SOOT {
  const unsigned int gNClassNames = $nClassNames;
  const char* gClassNames[$nClassNames] = {
HERE

print $cc_oh qq{    "$_",\n} for sort keys %classes;

print $cc_oh <<'HERE';
  };
} // end namespace SOOT
HERE

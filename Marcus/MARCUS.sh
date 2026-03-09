#!/bin/bash

#-- Classical Marcus input generator for Gaussian16.
#-- Coded by Guillem P. 16022026
#-- It is recommended to have the input-output files into a separate folder
#   to avoid name incompatibilities

mol1=$1; mol2=$2
name1=$(basename "$1" ".log")
name2=$(basename "$2" ".log")

#-- Get route section lines for the calculations
/users/gpey/bin/gau2xyz $mol1
sed -i "1d" $name1.xyz
sed -i "1d" $name1.xyz
nLines1=$(wc -l < ${name1}.com)
if  ! grep -q "geom=check" $mol1; then
    nLinesXYZ1=$(wc -l < ${name1}.xyz)
    Head1=$(expr $nLines1 - $nLinesXYZ1 - 1)
    head -n $Head1 ${name1}.com > marcus${name1}.com
else
    Head1=$(expr $nLines1 - 1)
    head -n $Head1 ${name1}.com > marcus${name1}.com
fi

/users/gpey/bin/gau2xyz $mol2
sed -i "1d" $name2.xyz
sed -i "1d" $name2.xyz
nLines2=$(wc -l < ${name2}.com)
if ! grep -q "geom=check" $mol2; then
    nLinesXYZ2=$(wc -l < ${name2}.xyz)
    Head2=$(expr $nLines2 - $nLinesXYZ2 - 1)
    head -n $Head2 ${name2}.com > marcus${name2}.com
else
    Head2=$(expr $nLines2 - 1)
    head -n $Head2 ${name2}.com > marcus${name2}.com
fi

#-- Insert the counterpart geometry
cat ${name2}.xyz >> marcus${name1}.com
echo >> marcus${name1}.com
cat ${name1}.xyz >> marcus${name2}.com
echo >> marcus${name2}.com

#-- Remove the chk and oldchk lines
sed -i "/chk/d" marcus*.com
sed -i "s/geom=check guess=read //g" marcus*.com 2>/dev/null
sed -i "s/guess=read geom=check //g" marcus*.com 2>/dev/null

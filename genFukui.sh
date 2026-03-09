#!/bin/bash

#-- Generation of Fukui function inputs and Dual descriptors for Gaussian
#-- It requires:
#--     1) The pre-optimized geometry of the interest compounds *without NAtoms and comment*
#--     2) A template file with your desired route section

#-- The execution of genFukui.sh:
#   $ bash genFukui.sh (molCharge) (molMultiplicity) (Path to template file)

#-- Possible errors of calculations:
#       1) In the route section of your template there is the opt keyword
#       2) The geometry does not have the proper format for Gaussian

#-- Bash script written by Guillem Pey, 2026.

molCharge=$1; molMult=$2; molTemplateFile=$3
charges="0 1 -1"

ls -v *.xyz > geoms.txt
path2geoms=$(pwd)
for charge in $charges; do
    mkdir NBO_$charge 2>/dev/null
    if [[ $charge -eq 0 ]]; then
        while read mol; do
            molname=$(basename "$mol" ".xyz")
            cp $molTemplateFile ${molname}.com
            sed -i "s:PATH:${path2geoms}:g" ${molname}.com
            sed -i "s/GEOM/$mol/g" ${molname}.com 
            mv ${molname}.com NBO_${charge}/
        done < geoms.txt
    else
        newCharge=$(expr "$molCharge" + "$charge")
        newMult=$(expr "$molMult" + "1") 
        while read mol; do
            molname=$(basename "$mol" ".xyz")
            cp $molTemplateFile ${molname}.com
            sed -i "s/$molCharge $molMult/$newCharge $newMult/g" ${molname}.com
            sed -i "s:PATH:${path2geoms}:g" ${molname}.com
            sed -i "s/GEOM/$mol/g" ${molname}.com 
            mv ${molname}.com NBO_${charge}/
        done < geoms.txt
    fi
done
rm geoms.txt

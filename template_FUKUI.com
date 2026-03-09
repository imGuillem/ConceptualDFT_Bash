%nproc=4
%mem=8GB
# CAM-B3LYP/6-311+G(d,p) Pop=(NaturalOrbitals,NBO) SCF=(XQC,Tight) Integral=Ultrafine
SCRF=(SMD,solvent=water,read) empiricaldispersion=GD3BJ
Volume

Comment

0 1
@PATH/GEOM

Surface=SAS
Alpha=0.485


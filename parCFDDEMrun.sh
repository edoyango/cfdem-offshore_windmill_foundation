#!/bin/bash

#===================================================================#
# allrun script for testcase as part of test routine 
# run settlingTest CFD part
# Christoph Goniva - Feb. 2011
#===================================================================#

#- source CFDEM env vars
#. ~/.bashrc

#- include functions
source $CFDEM_SRC_DIR/lagrangian/cfdemParticle/etc/functions.sh

#--------------------------------------------------------------------------------#
#- define variables
casePath="$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
logpath=$casePath
headerText="offshore_windmill"
logfileName="log_$headerText"
solverName="cfdemSolverIB"
nrProcs="4"
machineFileName="none"   # yourMachinefileName | none
debugMode="off"          # on | off| strict
testHarnessPath="$CFDEM_TEST_HARNESS_PATH"
runOctave="false"
postproc="false"
#--------------------------------------------------------------------------------#

#- call function to run a parallel CFD-DEM case
blockMesh -case "$casePath"/CFD
decomposePar -case "$casePath"/CFD
parCFDDEMrun $logpath $logfileName $casePath $headerText $solverName $nrProcs $machineFileName $debugMode
reconstructPar -case "$casePath"/CFD -noLagrangian

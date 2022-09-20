#####################################
# File Name: gene-comment-file.sh
# Author: Daoxiong Wu
# mail: daoxiong@mail.ustc.edu.cn
# Created Time: Thu 02 Nov 2017 04:04:32 PM CST
########################################
#!/bin/bash

#generate comment-file after VASP calculation
dir=$1

nsw=$(grep "NSW" OUTCAR | tail -1 | awk '{print $3}')
E0=$(grep "without" OUTCAR |tail -1| awk '{printf "%12.6f \n", $7}')
EENTRO=$(grep "EENTRO" OUTCAR |tail -1| awk '{printf "%12.6f \n", $5}')
Edisp=$(grep "Edisp" OUTCAR |tail -1| awk '{printf "%12.5f \n", $3}')
MAGNE=$(grep "mag" OSZICAR |tail -1| awk '{printf "%12.4f \n", $10}')
require=$(grep "require" OUTCAR | awk '{printf "%s \n", $1}')
dE=$(grep "total energy-change" OUTCAR |tail -1| awk  '{printf "%s \n", $NF}' | awk -F '[()]' '{printf "%s \n", $2}')
pressure=$(grep "external" OUTCAR |tail -1| awk '{printf "%12.2f \n", $4}')
Pullay=$(grep "external" OUTCAR |tail -1| awk '{printf "%12.2f \n", $9}')
Time=$(grep "Elapsed" OUTCAR |tail -1| awk '{printf "%12.0f \n", $4}')

sta_sym=$(grep "static configuration" OUTCAR | awk '{printf "%s \n", $8}')
dyn_sym=$(grep "dynamic configuration" OUTCAR | awk '{printf "%s \n", $8}')
mag_sym=$(grep "magnetic configuration" OUTCAR | awk '{printf "%s \n", $8}')

if [ "$Edisp" = "" ] ; then
	Edisp=--
else
	a=a
fi		

if [ "$MAGNE" = "" ] ; then
	MAGNE=--
else
	a=a
fi

if [ "$require" = "" ] ; then
	require=o_o
else
	a=a
fi		

echo ====================$dir==================== > comment-$dir
if [ "$nsw" = "0" ] ; then
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "E0       EENTRO   dE       pressure time     MAGNE    Edisp    Pullay"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "======== ======== ======== ======== ======== ======== ======== ========"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo $E0   	$EENTRO	 $dE      $pressure $Time	$MAGNE   $Edisp   $Pullay` >>comment-$dir

    printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "sta_sym  dyn_sym  mag_sym  xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "======== ======== ======== ======== ======== ======== ======== ========"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo $sta_sym  $dyn_sym $mag_sym ` >>comment-$dir
    
    
else
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "E0       EENTRO   require  pressure time     MAGNE    Edisp    Pullay"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "======== ======== ======== ======== ======== ======== ======== ========"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo $E0    	$EENTRO  $require $pressure $Time   $MAGNE   $Edisp   $Pullay` >>comment-$dir
 
    printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "sta_sym  dyn_sym  mag_sym  xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo "======== ======== ======== ======== ======== ======== ======== ========"` >>comment-$dir
	printf '%10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t %10s\t \n' `echo $sta_sym  $dyn_sym $mag_sym ` >>comment-$dir
fi

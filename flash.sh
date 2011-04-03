#!/bin/bash
# flash0r - play current opened flash video containers 
#
# depends on: grep, mplayer, sed

# get PID of plugin-container
# maybe this is usefull too ps -A | grep containe |  cut -d ' ' -f 1  (-f  1-2 etc)
pwd=$(pwd)
echo $pwd
flash=( $(ps ax | grep plugin-container |grep -v ' grep ') )
echo ${flash[0]}
cd /proc/${flash[0]}/fd
#file *
file=($( file * | grep FlashX | grep '[0-9]\{2,3\}'))
let count=${#file[@]}/7
blub=($(echo ${file[0]} |sed -e 's/:/\n/g'))
tmp=0;
size=${#file[@]}

### build parameter for mplayer
param=""
for x in $*
do
	param=$(echo ${param} $x)
done


echo "Mplayer Parameters are:" ${param}
videos=""
for ((tmp=0;tmp<${size};))
do
	blub=($(echo ${file[$tmp]} |sed -e 's/:/\n/g'))
	echo $blub
	echo Video: ${blub} Params: $1
	videos=$(echo ${videos} ${blub})
	#mplayer $param ${blub}
	let tmp=${tmp}+7
	echo $tmp $i
done	
mplayer $param $videos
cd $pwd

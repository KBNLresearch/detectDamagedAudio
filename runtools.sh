#!/bin/bash

# Path to jhove

jhove=~/jhove/jhove

# Installation directory
instDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $instDir

# Data directory - where files are stored
dataDir="$instDir"/data

# Output directory - tool output goes here
outDir="$instDir"/output

# Output files for all tools
outJhoveDefault=$outDir/jhoveDefault.txt
outJhoveWave=$outDir/jhoveWave.txt
outShntool=$outDir/shntool.txt
outFfmpeg=$outDir/ffmpeg.txt
outMediainfo=$outDir/mediainfo.txt
outFlac=$outDir/flac.txt

# Remove any old instances of output files
rm "$outDir"/*

for inputFile in $dataDir/*; do

    echo '### '$inputFile >> $outJhoveDefault
    $jhove $inputFile >> $outJhoveDefault
    echo '### ' $inputFile >> $outJhoveWave
    $jhove -m WAVE-hul $inputFile >> $outJhoveWave
    echo '### ' $inputFile >> $outShntool
    shntool info $inputFile >> $outShntool
    echo '### ' $inputFile >> $outFfmpeg
    ffmpeg -v error -i $inputFile -f null - 2>> $outFfmpeg 
    echo '### ' $inputFile >> $outMediainfo
    mediainfo $inputFile -show_format -show_streams >> $outMediainfo
    echo '### ' $inputFile >> $outFlac
    flac -t $inputFile 2>> $outFlac
done


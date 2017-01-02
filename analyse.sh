#!/bin/bash

# Path to jhove

jhove=~/jhove/jhove

# Installation directory
instDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Data directory - where files are stored
dataDir="$instDir"/data/

# Output directory - tool output goes here
outDir="$instDir"/output

# Remove any old instances of output files

rm "$outDir"/*

while IFS= read -d $'\0' inputFile ; do

    echo $inputFile
    $jhove $inputFile >> $outDir/jhoveDefault.txt
    $jhove -m WAVE-hul $inputFile >> $outDir/jhoveWave.txt
    shntool info $inputFile >> $outDir/shntool.txt
    ffprobe $inputFile -show_format -show_streams >> $outDir/ffprobe.txt
    mediainfo $inputFile -show_format -show_streams >> $outDir/mediainfo.txt

done < <(find "$dataDir" -maxdepth 1 -mindepth 1 -print0 -type f)

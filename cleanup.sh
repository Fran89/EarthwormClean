#!/bin/sh 

# Source and CD into Log
source /home/earthworm/params/ew_linux.bash
cd $EW_LOG

# Get Today date in seconds 
today=$(date --date=$(date "+%D") +%s)

# Define the threshold
numDays=3
threshold=$(($numDays * 24 * 60 * 60))

# Start finding files 
find . -type f | while read fileName
do
  # Get date from filename
  fileDate=$(echo $fileName | grep -o '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*log' | sed 's/.log//g')
  # Get the date in seconds
  fileDateSec=$(date --date=$fileDate +%s)
  diffInSec=$(($today-$fileDateSec))
  # Verify the threshold
  if [ "$diffInSec" -ge "$threshold" ]
    then
      rm $fileName
  fi
done

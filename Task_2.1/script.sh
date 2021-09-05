#!/bin/bash
#simple check input file and parameters
if [ -f $1 ]; then
  inputFile=$1
  else
  echo "Invalid input file"
fi

if [ "$2" == "-F" ]; then
  firstName=$3
  else
  firstName="Vasya"
fi

if [ "$4" == "-L" ]; then
  lastName=$5
  else
  lastName="Pupkin"
fi

ip=$(hostname -I)
date=$(date)

awk -v ip=$ip -v hostname=$HOSTNAME -v date="$date" -v firstName=$firstName -v lastName=$lastName '
  {
    gsub("{{hostname}}", hostname)
    gsub("{{ip}}", ip)
    gsub("{{current_date}}", date)
    gsub("{{home_folder}}", ENVIRON["HOME"])
    gsub("{{username}}", ENVIRON["USER"])
    gsub("{{first_name}}", firstName)
    gsub("{{last_name}}", lastName)
    print > "output.yml"
  }
' $inputFile
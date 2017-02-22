#!/usr/local/bin/bash
directory="./Scripting"
#if statement ot check if directory exisists
if [ -d $directory ]; then
  echo "Directory exists"
else
  echo "Directory does not exist"
fi

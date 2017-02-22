#!/usr/local/bin/bash
#stores file argument as file
file=$1

#final score

password=$(cat $1)
score=${#password}

#check if password is within range
if [ $score -lt 6 ]; then
  echo "Error: Password length invalid."
  exit
fi
if [ $score -gt 32 ]; then
  echo "Error: Password length invalid."
  exit
fi

if egrep -q ['#$+%@'] $file ; then
  let score=score+5
fi

if egrep -q [0-9] $file ; then
    let score=score+5
fi

if egrep -q [A-z] $file ; then
  let score=score+5
fi

if egrep -q "([A-z])\1+" $file ; then
  let score=score-10
elif egrep -q "([0-9])\1+" $file ; then
  let score=score-10
fi

if egrep -q [a-z][a-z][a-z] $file ; then
  let score=score-3
fi

if egrep -q [A-Z][A-Z][A-Z] $file ; then
  let score=score-3
fi 

if egrep -q [0-9][0-9][0-9] $file ; then
  let score=score-3
fi

echo Password Score: $score
exit

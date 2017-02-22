#!/usr/local/bin/bash
temp="elacroix@purdue.edu"
name="Emilia"
echo "Hello $name!!" > temp-message
echo >> temp-message
echo "Stop typing so rough" >> temp-message
echo >> temp-message
echo "Sincerely," >> temp-message
echo ":)" >> temp-message
/usr/bin/mailx -s "mail-hello" $temp < temp-message
echo "Message sent."

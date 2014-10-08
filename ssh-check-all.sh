#!/bin/bash
######################################
#
# SSL-Check Certificate Checker
# Author: Trey Brister 2014
#
# URL: http://www.shellhacks.com/en/HowTo-Check-SSL-Certificate-Expiration-Date-from-the-Linux-Shell
# URL: http://stackoverflow.com/questions/5155923/sending-a-mail-from-a-linux-shell-script
# URL: http://stackoverflow.com/questions/4946785/how-to-find-the-difference-in-days-between-two-dates
# URL: http://www.thegeekstuff.com/2011/07/bash-for-loop-examples/
#
######################################
## List of the domains

for DOMAINS in \
example.be example.com example.net google.com
do
  ./ssl-check.sh $DOMAINS
done

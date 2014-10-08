#!/bin/bash
######################################
#
# SSL-Check Certificate Checker
# Author: Trey Brister 2014
#
# URL: http://www.shellhacks.com/en/HowTo-Check-SSL-Certificate-Expiration-Date-from-the-Linux-Shell
# URL: http://www.thegeekstuff.com/2011/07/bash-for-loop-examples/
#
######################################
## List of the domains

for DOMAINS in \
example.be example.com example.net google.com
do
  ./ssl-check.sh $DOMAINS
done

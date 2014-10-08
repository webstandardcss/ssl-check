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

## If no argument is supplied then exit with a helpful message
[[ $@ ]] || { echo "To check the SSL certificate, please enter your domain name"; exit 1; }

## Variables to start off with

# Amount of time before expiration to receive alerts every day (Default: 7)
# Will still receive 14 and 30 day notices in addition to ${ALERTDAYS} 
# Usage: ${ALERTDAYS}
export ALERTDAYS=7

# Get the domain name from the SSL certificate
# Usage: ${DOMAIN}
export DOMAIN=$(echo | openssl s_client -connect ${1}:443 2>/dev/null | openssl x509 -noout -subject|cut -d= -f4|cut -d/ -f1)

# SSL certificate expiration date formatted like YYYY-MM-DD
# Usage: ${EXPIRATION}
export EXPIRATION=$(date -d "$(echo | openssl s_client -connect ${1}:443 2>/dev/null | openssl x509 -noout -dates|grep notAfter|cut -d= -f2)" +%Y-%m-%d)

# Get todays date formated like YYYY-MM-DD
# Usage: ${TODAY}
export TODAY=$(date +%Y-%m-%d)

# Use mysql to subtract the two dates
# I log into mysql with a test account that has no access to any databases
# Usage: $(DIFF)
DIFF () {
    echo "select datediff('$EXPIRATION', '$TODAY');"  | mysql -N -u igo_test -ptest1516
}

# New line just in case its needed 
# Its not required inside of the below $MESSAGE HEREDOC
# Usage: ${NL}
export NL=$'\n'

## Start of the message to be emailed
# Admin email address to receive the alerts
export EMAIL="test1516@igomobilemarketing.com"

# Subject line for the email alert
export SUBJECT="${DOMAIN} SSL Cert Expiring In $(DIFF) Days"

# This is the message that is sent with the email alerts 
# and it contains data variables mixed in the text
# Usage: echo ${MESSAGE}
export MESSAGE=$(cat <<EOF

SSL Certs Are Expiring

Today is ${TODAY}

Your SSL certificate for ${DOMAIN} 
is about to expire.

The expiration date is ${EXPIRATION}

This means you have $(DIFF) days 
remaining before your secure certificate 
will expire leaving your website unprotected.

To stop these messages, renew the startssl.com certificate for
this domain ${DOMAIN} within the next $(DIFF) days.

Thank you,
BoonYah Management Team

EOF
); MESSAGE=${MESSAGE%a}



# Mail sending function for the email alerts
# Usage: $(SEND)
SEND () {
  mail -s "$SUBJECT" "$EMAIL" <<< "$MESSAGE"; exit 1
}
#$(SEND)


# Send alerts 30, 14, 7, 6, 5, 4, 3, 2, 1 days before expiration
if [[ $(DIFF) -le ${ALERTDAYS} || $(DIFF) -eq 14 || $(DIFF) -eq 30 ]];
  then 

    $(SEND); echo "Email Alert Message Sent" 
  
    echo -e Message: "$MESSAGE"
    echo Subject: $SUBJECT
    echo Alert To: $EMAIL

  else
 
    echo " The ${DOMAIN} SSL certificate will not expire for another $(DIFF) days. "; 
fi

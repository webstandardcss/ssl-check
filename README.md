## SSL-Check Certificate Checker

SSL-Check Certificate Checker can batch check multiple domains for expired SSL certificates, automatically alert your email when your certificate is about to expire.

You can set the ALERTDAYS configuration setting to control when you start receiving emails.

Every time the script is run. Script will send mail if the certificate expires sooner than ALERTDAYS days.

If you want to receive email every time you run this script then set ALERTDAYS to 99999. (Default 7 Days)

To check the SSL certificate, please enter your domain name as the command argument.

You can add your domain names to the list in the ssl-check-all.sh file

Cron can be set twice daily using cPanel or crontab -e

```bash
0	0,12	*	*	*	/home/username/bin/ssl-check-all
```

### Usage: ssl-check domain.com

### Author: Trey Brister 2014

* http://www.shellhacks.com/en/HowTo-Check-SSL-Certificate-Expiration-Date-from-the-Linux-Shell
* http://stackoverflow.com/questions/5155923/sending-a-mail-from-a-linux-shell-script
* http://stackoverflow.com/questions/4946785/how-to-find-the-difference-in-days-between-two-dates
* http://www.thegeekstuff.com/2011/07/bash-for-loop-examples/

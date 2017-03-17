#!/bin/sh
# cd /opt/fhem; /usr/bin/perl /opt/fhem/fhem.pl /opt/fhem/fhem-main.cfg | /usr/bin/tee -a ./log/fhem-$(date +%Y-%m).log
cd /opt/fhem
perl fhem.pl /config/fhem.cfg

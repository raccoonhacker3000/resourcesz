#!/bin/bash

source ./colors.sh

PrintLightBlue "Debsums Baseline"
mkdir ./output/debsums
apt install debsums

debsums > ./output/debsums/sums.txt
grep -v "OK" ./output/debsums/sums.txt > ./output/debsums/errors.txt
grep "missing" ./output/debsums/errors.txt > ./output/debsums/missing-files.txt

PrintGreen "Debsums Complete!"



PrintLightBlue "Lynis Baseline"
mkdir /lynis-baseline
apt install lynis
lynis audit system --report-file ./output/lynis-baseline/report.dat

cat -n ./output/lynis-baseline/report.dat | grep -E 'warning|suggestion' | sed -e 's/warning\[\]\=//g' | sed -e 's/suggestion\[\]\=//g' > /lynis-baseline/suggestions.txt
PrintCyan "Suggestions and Warnings:  ./output/lynis-baseline/suggestions"

cat -n ./output/lynis-baseline/report.dat | grep -E 'details' | sed -e 's/details\[\]=//g' > /lynis-baseline/details.txt
PrintCyan "Additional Details:  ./output/lynis-baseline/details.txt\n"

cat ./output/lynis-baseline/report.dat | grep -E 'running_service' | sed -e 's/running_service\[\]=//g' > /lynis-baseline/running-services.txt
PrintCyan "Running Services:  ./output/lynis-baseline/running-services.txt"

cat ./output/lynis-baseline/report.dat | grep -E 'boot_service' | sed -e 's/boot_service\[\]=//g' > /lynis-baseline/boot-services.txt
PrintCyan "Boot Services:  ./output/lynis-baseline/boot-services.txt"

cat ./output/lynis-baseline/report.dat | grep -E 'available_shell' | sed -e 's/available_shell\[\]=//g' > /lynis-baseline/available-shells.txt
PrintCyan "Available Shells:  ./output/lynis-baseline/available-shells.txt"

cat ./output/lynis-baseline/report.dat | grep -E 'network_listen' | sed -e 's/network_listen\[\]=//g' > /lynis-baseline/network-listens.txt
PrintCyan "Network Listens:  ./output/lynis-baseline/network-listens.txt"

cat ./output/lynis-baseline/report.dat | grep -E 'cronjob' | sed -e 's/cronjob\[\]=//g' > /lynis-baseline/cronjobs.txt
PrintCyan "Cronjobs:  ./output/lynis-baseline/cronjobs.txt"

PrintGreen "Lynis Baseline Complete!"


PrintLightBlue "LUNAR Baseline"
apt install git
git clone https://github.com/lateralblast/lunar.git
purge git

sed -i 's:#!/bin/sh -eu:#!/bin/bash:' /lunar/lunar.sh
mkdir ./output/lunar-baseline
./output/lunar/lunar.sh -A -n > ./output/lunar-baseline/report.txt
cat -n ./output/lunar-baseline/report.txt | grep "Warning:" > ./output/lunar-baseline/warnings.txt

PrintGreen "LUNAR Complete!"

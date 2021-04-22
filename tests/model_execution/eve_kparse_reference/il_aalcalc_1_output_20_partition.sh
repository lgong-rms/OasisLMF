#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +

rm -R -f fifo/*
rm -R -f work/*
mkdir work/kat/

mkdir work/il_S1_summaryaalcalc

mkfifo fifo/il_P1
mkfifo fifo/il_P2
mkfifo fifo/il_P3
mkfifo fifo/il_P4
mkfifo fifo/il_P5
mkfifo fifo/il_P6
mkfifo fifo/il_P7
mkfifo fifo/il_P8
mkfifo fifo/il_P9
mkfifo fifo/il_P10

mkfifo fifo/il_S1_summary_P1

mkfifo fifo/il_S1_summary_P2

mkfifo fifo/il_S1_summary_P3

mkfifo fifo/il_S1_summary_P4

mkfifo fifo/il_S1_summary_P5

mkfifo fifo/il_S1_summary_P6

mkfifo fifo/il_S1_summary_P7

mkfifo fifo/il_S1_summary_P8

mkfifo fifo/il_S1_summary_P9

mkfifo fifo/il_S1_summary_P10

mkfifo fifo/gul_lb_P1
mkfifo fifo/gul_lb_P2
mkfifo fifo/gul_lb_P3
mkfifo fifo/gul_lb_P4
mkfifo fifo/gul_lb_P5
mkfifo fifo/gul_lb_P6
mkfifo fifo/gul_lb_P7
mkfifo fifo/gul_lb_P8
mkfifo fifo/gul_lb_P9
mkfifo fifo/gul_lb_P10

mkfifo fifo/lb_il_P1
mkfifo fifo/lb_il_P2
mkfifo fifo/lb_il_P3
mkfifo fifo/lb_il_P4
mkfifo fifo/lb_il_P5
mkfifo fifo/lb_il_P6
mkfifo fifo/lb_il_P7
mkfifo fifo/lb_il_P8
mkfifo fifo/lb_il_P9
mkfifo fifo/lb_il_P10



# --- Do insured loss computes ---


tee < fifo/il_S1_summary_P1 work/il_S1_summaryaalcalc/P1.bin > /dev/null & pid1=$!
tee < fifo/il_S1_summary_P2 work/il_S1_summaryaalcalc/P2.bin > /dev/null & pid2=$!
tee < fifo/il_S1_summary_P3 work/il_S1_summaryaalcalc/P3.bin > /dev/null & pid3=$!
tee < fifo/il_S1_summary_P4 work/il_S1_summaryaalcalc/P4.bin > /dev/null & pid4=$!
tee < fifo/il_S1_summary_P5 work/il_S1_summaryaalcalc/P5.bin > /dev/null & pid5=$!
tee < fifo/il_S1_summary_P6 work/il_S1_summaryaalcalc/P6.bin > /dev/null & pid6=$!
tee < fifo/il_S1_summary_P7 work/il_S1_summaryaalcalc/P7.bin > /dev/null & pid7=$!
tee < fifo/il_S1_summary_P8 work/il_S1_summaryaalcalc/P8.bin > /dev/null & pid8=$!
tee < fifo/il_S1_summary_P9 work/il_S1_summaryaalcalc/P9.bin > /dev/null & pid9=$!
tee < fifo/il_S1_summary_P10 work/il_S1_summaryaalcalc/P10.bin > /dev/null & pid10=$!

summarycalc -f  -1 fifo/il_S1_summary_P1 < fifo/il_P1 &
summarycalc -f  -1 fifo/il_S1_summary_P2 < fifo/il_P2 &
summarycalc -f  -1 fifo/il_S1_summary_P3 < fifo/il_P3 &
summarycalc -f  -1 fifo/il_S1_summary_P4 < fifo/il_P4 &
summarycalc -f  -1 fifo/il_S1_summary_P5 < fifo/il_P5 &
summarycalc -f  -1 fifo/il_S1_summary_P6 < fifo/il_P6 &
summarycalc -f  -1 fifo/il_S1_summary_P7 < fifo/il_P7 &
summarycalc -f  -1 fifo/il_S1_summary_P8 < fifo/il_P8 &
summarycalc -f  -1 fifo/il_S1_summary_P9 < fifo/il_P9 &
summarycalc -f  -1 fifo/il_S1_summary_P10 < fifo/il_P10 &

eve -R 1 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P1  &
eve -R 2 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P2  &
eve -R 3 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P3  &
eve -R 4 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P4  &
eve -R 5 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P5  &
eve -R 6 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P6  &
eve -R 7 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P7  &
eve -R 8 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P8  &
eve -R 9 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P9  &
eve -R 10 10 | getmodel | gulcalc -S100 -L100 -r -a0 -i - > fifo/gul_lb_P10  &
load_balancer -i fifo/gul_lb_P1 fifo/gul_lb_P2 -o fifo/lb_il_P1 fifo/lb_il_P2 &
load_balancer -i fifo/gul_lb_P3 fifo/gul_lb_P4 -o fifo/lb_il_P3 fifo/lb_il_P4 &
load_balancer -i fifo/gul_lb_P5 fifo/gul_lb_P6 -o fifo/lb_il_P5 fifo/lb_il_P6 &
load_balancer -i fifo/gul_lb_P7 fifo/gul_lb_P8 -o fifo/lb_il_P7 fifo/lb_il_P8 &
load_balancer -i fifo/gul_lb_P9 fifo/gul_lb_P10 -o fifo/lb_il_P9 fifo/lb_il_P10 &
fmcalc -a2 < fifo/lb_il_P1 > fifo/il_P1 &
fmcalc -a2 < fifo/lb_il_P2 > fifo/il_P2 &
fmcalc -a2 < fifo/lb_il_P3 > fifo/il_P3 &
fmcalc -a2 < fifo/lb_il_P4 > fifo/il_P4 &
fmcalc -a2 < fifo/lb_il_P5 > fifo/il_P5 &
fmcalc -a2 < fifo/lb_il_P6 > fifo/il_P6 &
fmcalc -a2 < fifo/lb_il_P7 > fifo/il_P7 &
fmcalc -a2 < fifo/lb_il_P8 > fifo/il_P8 &
fmcalc -a2 < fifo/lb_il_P9 > fifo/il_P9 &
fmcalc -a2 < fifo/lb_il_P10 > fifo/il_P10 &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10


# --- Do insured loss kats ---


aalcalc -Kil_S1_summaryaalcalc > output/il_S1_aalcalc.csv & lpid1=$!
wait $lpid1

rm -R -f work/*
rm -R -f fifo/*

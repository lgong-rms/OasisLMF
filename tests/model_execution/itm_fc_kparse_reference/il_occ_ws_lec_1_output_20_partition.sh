#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir output/full_correlation/

rm -R -f fifo/*
mkdir fifo/full_correlation/
rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

mkdir work/il_S1_summaryleccalc
mkdir work/full_correlation/il_S1_summaryleccalc

mkfifo fifo/full_correlation/gul_fc_P1
mkfifo fifo/full_correlation/gul_fc_P2
mkfifo fifo/full_correlation/gul_fc_P3
mkfifo fifo/full_correlation/gul_fc_P4
mkfifo fifo/full_correlation/gul_fc_P5
mkfifo fifo/full_correlation/gul_fc_P6
mkfifo fifo/full_correlation/gul_fc_P7
mkfifo fifo/full_correlation/gul_fc_P8
mkfifo fifo/full_correlation/gul_fc_P9
mkfifo fifo/full_correlation/gul_fc_P10
mkfifo fifo/full_correlation/gul_fc_P11
mkfifo fifo/full_correlation/gul_fc_P12
mkfifo fifo/full_correlation/gul_fc_P13
mkfifo fifo/full_correlation/gul_fc_P14
mkfifo fifo/full_correlation/gul_fc_P15
mkfifo fifo/full_correlation/gul_fc_P16
mkfifo fifo/full_correlation/gul_fc_P17
mkfifo fifo/full_correlation/gul_fc_P18
mkfifo fifo/full_correlation/gul_fc_P19
mkfifo fifo/full_correlation/gul_fc_P20

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
mkfifo fifo/il_P11
mkfifo fifo/il_P12
mkfifo fifo/il_P13
mkfifo fifo/il_P14
mkfifo fifo/il_P15
mkfifo fifo/il_P16
mkfifo fifo/il_P17
mkfifo fifo/il_P18
mkfifo fifo/il_P19
mkfifo fifo/il_P20

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

mkfifo fifo/il_S1_summary_P11

mkfifo fifo/il_S1_summary_P12

mkfifo fifo/il_S1_summary_P13

mkfifo fifo/il_S1_summary_P14

mkfifo fifo/il_S1_summary_P15

mkfifo fifo/il_S1_summary_P16

mkfifo fifo/il_S1_summary_P17

mkfifo fifo/il_S1_summary_P18

mkfifo fifo/il_S1_summary_P19

mkfifo fifo/il_S1_summary_P20

mkfifo fifo/full_correlation/il_P1
mkfifo fifo/full_correlation/il_P2
mkfifo fifo/full_correlation/il_P3
mkfifo fifo/full_correlation/il_P4
mkfifo fifo/full_correlation/il_P5
mkfifo fifo/full_correlation/il_P6
mkfifo fifo/full_correlation/il_P7
mkfifo fifo/full_correlation/il_P8
mkfifo fifo/full_correlation/il_P9
mkfifo fifo/full_correlation/il_P10
mkfifo fifo/full_correlation/il_P11
mkfifo fifo/full_correlation/il_P12
mkfifo fifo/full_correlation/il_P13
mkfifo fifo/full_correlation/il_P14
mkfifo fifo/full_correlation/il_P15
mkfifo fifo/full_correlation/il_P16
mkfifo fifo/full_correlation/il_P17
mkfifo fifo/full_correlation/il_P18
mkfifo fifo/full_correlation/il_P19
mkfifo fifo/full_correlation/il_P20

mkfifo fifo/full_correlation/il_S1_summary_P1

mkfifo fifo/full_correlation/il_S1_summary_P2

mkfifo fifo/full_correlation/il_S1_summary_P3

mkfifo fifo/full_correlation/il_S1_summary_P4

mkfifo fifo/full_correlation/il_S1_summary_P5

mkfifo fifo/full_correlation/il_S1_summary_P6

mkfifo fifo/full_correlation/il_S1_summary_P7

mkfifo fifo/full_correlation/il_S1_summary_P8

mkfifo fifo/full_correlation/il_S1_summary_P9

mkfifo fifo/full_correlation/il_S1_summary_P10

mkfifo fifo/full_correlation/il_S1_summary_P11

mkfifo fifo/full_correlation/il_S1_summary_P12

mkfifo fifo/full_correlation/il_S1_summary_P13

mkfifo fifo/full_correlation/il_S1_summary_P14

mkfifo fifo/full_correlation/il_S1_summary_P15

mkfifo fifo/full_correlation/il_S1_summary_P16

mkfifo fifo/full_correlation/il_S1_summary_P17

mkfifo fifo/full_correlation/il_S1_summary_P18

mkfifo fifo/full_correlation/il_S1_summary_P19

mkfifo fifo/full_correlation/il_S1_summary_P20



# --- Do insured loss computes ---


tee < fifo/il_S1_summary_P1 work/il_S1_summaryleccalc/P1.bin > /dev/null & pid1=$!
tee < fifo/il_S1_summary_P2 work/il_S1_summaryleccalc/P2.bin > /dev/null & pid2=$!
tee < fifo/il_S1_summary_P3 work/il_S1_summaryleccalc/P3.bin > /dev/null & pid3=$!
tee < fifo/il_S1_summary_P4 work/il_S1_summaryleccalc/P4.bin > /dev/null & pid4=$!
tee < fifo/il_S1_summary_P5 work/il_S1_summaryleccalc/P5.bin > /dev/null & pid5=$!
tee < fifo/il_S1_summary_P6 work/il_S1_summaryleccalc/P6.bin > /dev/null & pid6=$!
tee < fifo/il_S1_summary_P7 work/il_S1_summaryleccalc/P7.bin > /dev/null & pid7=$!
tee < fifo/il_S1_summary_P8 work/il_S1_summaryleccalc/P8.bin > /dev/null & pid8=$!
tee < fifo/il_S1_summary_P9 work/il_S1_summaryleccalc/P9.bin > /dev/null & pid9=$!
tee < fifo/il_S1_summary_P10 work/il_S1_summaryleccalc/P10.bin > /dev/null & pid10=$!
tee < fifo/il_S1_summary_P11 work/il_S1_summaryleccalc/P11.bin > /dev/null & pid11=$!
tee < fifo/il_S1_summary_P12 work/il_S1_summaryleccalc/P12.bin > /dev/null & pid12=$!
tee < fifo/il_S1_summary_P13 work/il_S1_summaryleccalc/P13.bin > /dev/null & pid13=$!
tee < fifo/il_S1_summary_P14 work/il_S1_summaryleccalc/P14.bin > /dev/null & pid14=$!
tee < fifo/il_S1_summary_P15 work/il_S1_summaryleccalc/P15.bin > /dev/null & pid15=$!
tee < fifo/il_S1_summary_P16 work/il_S1_summaryleccalc/P16.bin > /dev/null & pid16=$!
tee < fifo/il_S1_summary_P17 work/il_S1_summaryleccalc/P17.bin > /dev/null & pid17=$!
tee < fifo/il_S1_summary_P18 work/il_S1_summaryleccalc/P18.bin > /dev/null & pid18=$!
tee < fifo/il_S1_summary_P19 work/il_S1_summaryleccalc/P19.bin > /dev/null & pid19=$!
tee < fifo/il_S1_summary_P20 work/il_S1_summaryleccalc/P20.bin > /dev/null & pid20=$!

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
summarycalc -f  -1 fifo/il_S1_summary_P11 < fifo/il_P11 &
summarycalc -f  -1 fifo/il_S1_summary_P12 < fifo/il_P12 &
summarycalc -f  -1 fifo/il_S1_summary_P13 < fifo/il_P13 &
summarycalc -f  -1 fifo/il_S1_summary_P14 < fifo/il_P14 &
summarycalc -f  -1 fifo/il_S1_summary_P15 < fifo/il_P15 &
summarycalc -f  -1 fifo/il_S1_summary_P16 < fifo/il_P16 &
summarycalc -f  -1 fifo/il_S1_summary_P17 < fifo/il_P17 &
summarycalc -f  -1 fifo/il_S1_summary_P18 < fifo/il_P18 &
summarycalc -f  -1 fifo/il_S1_summary_P19 < fifo/il_P19 &
summarycalc -f  -1 fifo/il_S1_summary_P20 < fifo/il_P20 &

# --- Do insured loss computes ---


tee < fifo/full_correlation/il_S1_summary_P1 work/full_correlation/il_S1_summaryleccalc/P1.bin > /dev/null & pid21=$!
tee < fifo/full_correlation/il_S1_summary_P2 work/full_correlation/il_S1_summaryleccalc/P2.bin > /dev/null & pid22=$!
tee < fifo/full_correlation/il_S1_summary_P3 work/full_correlation/il_S1_summaryleccalc/P3.bin > /dev/null & pid23=$!
tee < fifo/full_correlation/il_S1_summary_P4 work/full_correlation/il_S1_summaryleccalc/P4.bin > /dev/null & pid24=$!
tee < fifo/full_correlation/il_S1_summary_P5 work/full_correlation/il_S1_summaryleccalc/P5.bin > /dev/null & pid25=$!
tee < fifo/full_correlation/il_S1_summary_P6 work/full_correlation/il_S1_summaryleccalc/P6.bin > /dev/null & pid26=$!
tee < fifo/full_correlation/il_S1_summary_P7 work/full_correlation/il_S1_summaryleccalc/P7.bin > /dev/null & pid27=$!
tee < fifo/full_correlation/il_S1_summary_P8 work/full_correlation/il_S1_summaryleccalc/P8.bin > /dev/null & pid28=$!
tee < fifo/full_correlation/il_S1_summary_P9 work/full_correlation/il_S1_summaryleccalc/P9.bin > /dev/null & pid29=$!
tee < fifo/full_correlation/il_S1_summary_P10 work/full_correlation/il_S1_summaryleccalc/P10.bin > /dev/null & pid30=$!
tee < fifo/full_correlation/il_S1_summary_P11 work/full_correlation/il_S1_summaryleccalc/P11.bin > /dev/null & pid31=$!
tee < fifo/full_correlation/il_S1_summary_P12 work/full_correlation/il_S1_summaryleccalc/P12.bin > /dev/null & pid32=$!
tee < fifo/full_correlation/il_S1_summary_P13 work/full_correlation/il_S1_summaryleccalc/P13.bin > /dev/null & pid33=$!
tee < fifo/full_correlation/il_S1_summary_P14 work/full_correlation/il_S1_summaryleccalc/P14.bin > /dev/null & pid34=$!
tee < fifo/full_correlation/il_S1_summary_P15 work/full_correlation/il_S1_summaryleccalc/P15.bin > /dev/null & pid35=$!
tee < fifo/full_correlation/il_S1_summary_P16 work/full_correlation/il_S1_summaryleccalc/P16.bin > /dev/null & pid36=$!
tee < fifo/full_correlation/il_S1_summary_P17 work/full_correlation/il_S1_summaryleccalc/P17.bin > /dev/null & pid37=$!
tee < fifo/full_correlation/il_S1_summary_P18 work/full_correlation/il_S1_summaryleccalc/P18.bin > /dev/null & pid38=$!
tee < fifo/full_correlation/il_S1_summary_P19 work/full_correlation/il_S1_summaryleccalc/P19.bin > /dev/null & pid39=$!
tee < fifo/full_correlation/il_S1_summary_P20 work/full_correlation/il_S1_summaryleccalc/P20.bin > /dev/null & pid40=$!

summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P1 < fifo/full_correlation/il_P1 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P2 < fifo/full_correlation/il_P2 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P3 < fifo/full_correlation/il_P3 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P4 < fifo/full_correlation/il_P4 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P5 < fifo/full_correlation/il_P5 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P6 < fifo/full_correlation/il_P6 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P7 < fifo/full_correlation/il_P7 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P8 < fifo/full_correlation/il_P8 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P9 < fifo/full_correlation/il_P9 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P10 < fifo/full_correlation/il_P10 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P11 < fifo/full_correlation/il_P11 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P12 < fifo/full_correlation/il_P12 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P13 < fifo/full_correlation/il_P13 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P14 < fifo/full_correlation/il_P14 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P15 < fifo/full_correlation/il_P15 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P16 < fifo/full_correlation/il_P16 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P17 < fifo/full_correlation/il_P17 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P18 < fifo/full_correlation/il_P18 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P19 < fifo/full_correlation/il_P19 &
summarycalc -f  -1 fifo/full_correlation/il_S1_summary_P20 < fifo/full_correlation/il_P20 &

fmcalc -a2 < fifo/full_correlation/gul_fc_P1 > fifo/full_correlation/il_P1 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P2 > fifo/full_correlation/il_P2 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P3 > fifo/full_correlation/il_P3 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P4 > fifo/full_correlation/il_P4 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P5 > fifo/full_correlation/il_P5 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P6 > fifo/full_correlation/il_P6 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P7 > fifo/full_correlation/il_P7 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P8 > fifo/full_correlation/il_P8 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P9 > fifo/full_correlation/il_P9 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P10 > fifo/full_correlation/il_P10 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P11 > fifo/full_correlation/il_P11 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P12 > fifo/full_correlation/il_P12 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P13 > fifo/full_correlation/il_P13 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P14 > fifo/full_correlation/il_P14 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P15 > fifo/full_correlation/il_P15 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P16 > fifo/full_correlation/il_P16 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P17 > fifo/full_correlation/il_P17 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P18 > fifo/full_correlation/il_P18 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P19 > fifo/full_correlation/il_P19 &
fmcalc -a2 < fifo/full_correlation/gul_fc_P20 > fifo/full_correlation/il_P20 &
eve 1 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P1 -a1 -i - | fmcalc -a2 > fifo/il_P1  &
eve 2 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P2 -a1 -i - | fmcalc -a2 > fifo/il_P2  &
eve 3 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P3 -a1 -i - | fmcalc -a2 > fifo/il_P3  &
eve 4 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P4 -a1 -i - | fmcalc -a2 > fifo/il_P4  &
eve 5 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P5 -a1 -i - | fmcalc -a2 > fifo/il_P5  &
eve 6 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P6 -a1 -i - | fmcalc -a2 > fifo/il_P6  &
eve 7 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P7 -a1 -i - | fmcalc -a2 > fifo/il_P7  &
eve 8 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P8 -a1 -i - | fmcalc -a2 > fifo/il_P8  &
eve 9 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P9 -a1 -i - | fmcalc -a2 > fifo/il_P9  &
eve 10 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P10 -a1 -i - | fmcalc -a2 > fifo/il_P10  &
eve 11 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P11 -a1 -i - | fmcalc -a2 > fifo/il_P11  &
eve 12 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P12 -a1 -i - | fmcalc -a2 > fifo/il_P12  &
eve 13 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P13 -a1 -i - | fmcalc -a2 > fifo/il_P13  &
eve 14 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P14 -a1 -i - | fmcalc -a2 > fifo/il_P14  &
eve 15 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P15 -a1 -i - | fmcalc -a2 > fifo/il_P15  &
eve 16 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P16 -a1 -i - | fmcalc -a2 > fifo/il_P16  &
eve 17 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P17 -a1 -i - | fmcalc -a2 > fifo/il_P17  &
eve 18 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P18 -a1 -i - | fmcalc -a2 > fifo/il_P18  &
eve 19 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P19 -a1 -i - | fmcalc -a2 > fifo/il_P19  &
eve 20 20 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P20 -a1 -i - | fmcalc -a2 > fifo/il_P20  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20 $pid21 $pid22 $pid23 $pid24 $pid25 $pid26 $pid27 $pid28 $pid29 $pid30 $pid31 $pid32 $pid33 $pid34 $pid35 $pid36 $pid37 $pid38 $pid39 $pid40


# --- Do insured loss kats ---


# --- Do insured loss kats for fully correlated output ---


leccalc -r -Kil_S1_summaryleccalc -w output/il_S1_leccalc_wheatsheaf_oep.csv & lpid1=$!
leccalc -r -Kfull_correlation/il_S1_summaryleccalc -w output/full_correlation/il_S1_leccalc_wheatsheaf_oep.csv & lpid2=$!
wait $lpid1 $lpid2

rm -R -f work/*
rm -R -f fifo/*

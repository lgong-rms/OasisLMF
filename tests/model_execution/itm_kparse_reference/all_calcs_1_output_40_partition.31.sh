#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output/* ! -name '*summary-info*' -type f -exec rm -f {} +

rm -R -f work/*
mkdir work/kat/

mkdir work/gul_S1_summaryleccalc
mkdir work/gul_S1_summaryaalcalc
mkdir work/il_S1_summaryleccalc
mkdir work/il_S1_summaryaalcalc

mkfifo fifo/gul_P32

mkfifo fifo/il_P32

mkfifo fifo/gul_S1_summary_P32
mkfifo fifo/gul_S1_summaryeltcalc_P32
mkfifo fifo/gul_S1_eltcalc_P32
mkfifo fifo/gul_S1_summarysummarycalc_P32
mkfifo fifo/gul_S1_summarycalc_P32
mkfifo fifo/gul_S1_summarypltcalc_P32
mkfifo fifo/gul_S1_pltcalc_P32

mkfifo fifo/il_S1_summary_P32
mkfifo fifo/il_S1_summaryeltcalc_P32
mkfifo fifo/il_S1_eltcalc_P32
mkfifo fifo/il_S1_summarysummarycalc_P32
mkfifo fifo/il_S1_summarycalc_P32
mkfifo fifo/il_S1_summarypltcalc_P32
mkfifo fifo/il_S1_pltcalc_P32



# --- Do insured loss computes ---
eltcalc -s < fifo/il_S1_summaryeltcalc_P32 > work/kat/il_S1_eltcalc_P32 & pid1=$!
summarycalctocsv -s < fifo/il_S1_summarysummarycalc_P32 > work/kat/il_S1_summarycalc_P32 & pid2=$!
pltcalc -s < fifo/il_S1_summarypltcalc_P32 > work/kat/il_S1_pltcalc_P32 & pid3=$!
tee < fifo/il_S1_summary_P32 fifo/il_S1_summaryeltcalc_P32 fifo/il_S1_summarypltcalc_P32 fifo/il_S1_summarysummarycalc_P32 work/il_S1_summaryaalcalc/P32.bin work/il_S1_summaryleccalc/P32.bin > /dev/null & pid4=$!
summarycalc -f  -1 fifo/il_S1_summary_P32 < fifo/il_P32 &

# --- Do ground up loss computes ---
eltcalc -s < fifo/gul_S1_summaryeltcalc_P32 > work/kat/gul_S1_eltcalc_P32 & pid5=$!
summarycalctocsv -s < fifo/gul_S1_summarysummarycalc_P32 > work/kat/gul_S1_summarycalc_P32 & pid6=$!
pltcalc -s < fifo/gul_S1_summarypltcalc_P32 > work/kat/gul_S1_pltcalc_P32 & pid7=$!
tee < fifo/gul_S1_summary_P32 fifo/gul_S1_summaryeltcalc_P32 fifo/gul_S1_summarypltcalc_P32 fifo/gul_S1_summarysummarycalc_P32 work/gul_S1_summaryaalcalc/P32.bin work/gul_S1_summaryleccalc/P32.bin > /dev/null & pid8=$!
summarycalc -i  -1 fifo/gul_S1_summary_P32 < fifo/gul_P32 &

eve 32 40 | getmodel | gulcalc -S100 -L100 -r -a1 -i - | tee fifo/gul_P32 | fmcalc -a2 > fifo/il_P32  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8


# --- Do insured loss kats ---

kat work/kat/il_S1_eltcalc_P32 > output/il_S1_eltcalc.csv & kpid1=$!
kat work/kat/il_S1_pltcalc_P32 > output/il_S1_pltcalc.csv & kpid2=$!
kat work/kat/il_S1_summarycalc_P32 > output/il_S1_summarycalc.csv & kpid3=$!

# --- Do ground up loss kats ---

kat work/kat/gul_S1_eltcalc_P32 > output/gul_S1_eltcalc.csv & kpid4=$!
kat work/kat/gul_S1_pltcalc_P32 > output/gul_S1_pltcalc.csv & kpid5=$!
kat work/kat/gul_S1_summarycalc_P32 > output/gul_S1_summarycalc.csv & kpid6=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6


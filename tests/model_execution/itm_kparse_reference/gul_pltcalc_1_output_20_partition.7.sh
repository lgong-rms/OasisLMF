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


mkfifo fifo/gul_P8

mkfifo fifo/gul_S1_summary_P8
mkfifo fifo/gul_S1_summarypltcalc_P8
mkfifo fifo/gul_S1_pltcalc_P8



# --- Do ground up loss computes ---
pltcalc -s < fifo/gul_S1_summarypltcalc_P8 > work/kat/gul_S1_pltcalc_P8 & pid1=$!
tee < fifo/gul_S1_summary_P8 fifo/gul_S1_summarypltcalc_P8 > /dev/null & pid2=$!
summarycalc -i  -1 fifo/gul_S1_summary_P8 < fifo/gul_P8 &

eve 8 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - > fifo/gul_P8  &

wait $pid1 $pid2


# --- Do ground up loss kats ---

kat work/kat/gul_S1_pltcalc_P8 > output/gul_S1_pltcalc.csv & kpid1=$!
wait $kpid1


#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---

set -e
set -o pipefail
mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output/* ! -name '*summary-info*' -type f -exec rm -f {} +
mkdir output/full_correlation/

rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

mkdir work/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryleccalc

mkfifo fifo/gul_P7

mkfifo fifo/gul_S1_summary_P7

mkfifo gul_S1_summary_P7



# --- Do ground up loss computes ---
tee < fifo/gul_S1_summary_P7 work/gul_S1_summaryleccalc/P7.bin > /dev/null & pid1=$!
summarycalc -i  -1 fifo/gul_S1_summary_P7 < fifo/gul_P7 &

eve 7 20 | getmodel | gulcalc -S100 -L100 -r -j gul_P7 -a1 -i - > fifo/gul_P7  &

wait $pid1

# --- Do computes for fully correlated output ---



# --- Do ground up loss computes ---
tee < gul_S1_summary_P7 work/full_correlation/gul_S1_summaryleccalc/P7.bin > /dev/null & pid1=$!
summarycalc -i  -1 gul_S1_summary_P7 < gul_P7 &

wait $pid1


# --- Do ground up loss kats ---


# --- Do ground up loss kats for fully correlated output ---


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

mkdir work/gul_S1_summaryaalcalc

mkfifo fifo/gul_P11

mkfifo fifo/gul_S1_summary_P11



# --- Do ground up loss computes ---
tee < fifo/gul_S1_summary_P11 work/gul_S1_summaryaalcalc/P11.bin > /dev/null & pid1=$!
summarycalc -i  -1 fifo/gul_S1_summary_P11 < fifo/gul_P11 &

eve 11 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - > fifo/gul_P11  &

wait $pid1


# --- Do ground up loss kats ---


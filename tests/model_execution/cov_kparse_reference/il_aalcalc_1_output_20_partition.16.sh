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

mkdir work/il_S1_summaryaalcalc

mkfifo fifo/il_P17

mkfifo fifo/il_S1_summary_P17



# --- Do insured loss computes ---
tee < fifo/il_S1_summary_P17 work/il_S1_summaryaalcalc/P17.bin > /dev/null & pid1=$!
summarycalc -f  -1 fifo/il_S1_summary_P17 < fifo/il_P17 &

eve 17 20 | getmodel | gulcalc -S100 -L100 -r -i - | fmcalc -a2 > fifo/il_P17  &

wait $pid1


# --- Do insured loss kats ---


#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---
set -euET -o pipefail
shopt -s inherit_errexit 2>/dev/null || echo "WARNING: Unable to set inherit_errexit. Possibly unsupported by this shell, Subprocess failures may not be detected."

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +

rm -R -f fifo/*
rm -R -f work/*
mkdir work/kat/

mkdir work/gul_S1_summaryaalcalc

mkfifo fifo/gul_P9

mkfifo fifo/gul_S1_summary_P9



# --- Do ground up loss computes ---
tee < fifo/gul_S1_summary_P9 work/gul_S1_summaryaalcalc/P9.bin > /dev/null & pid1=$!
summarycalc -m -g  -1 fifo/gul_S1_summary_P9 < fifo/gul_P9 &

eve 9 20 | getmodel | gulcalc -S100 -L100 -r -c - > fifo/gul_P9  &

wait $pid1


# --- Do ground up loss kats ---

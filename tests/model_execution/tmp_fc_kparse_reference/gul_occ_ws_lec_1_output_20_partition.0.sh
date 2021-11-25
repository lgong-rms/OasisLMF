#!/bin/bash
SCRIPT=$(readlink -f "$0") && cd $(dirname "$SCRIPT")

# --- Script Init ---
set -euET -o pipefail
shopt -s inherit_errexit 2>/dev/null || echo "WARNING: Unable to set inherit_errexit. Possibly unsupported by this shell, Subprocess failures may not be detected."

mkdir -p log
rm -R -f log/*

# --- Setup run dirs ---

find output -type f -not -name '*summary-info*' -not -name '*.json' -exec rm -R -f {} +
mkdir output/full_correlation/

rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

rm -R -f /tmp/%FIFO_DIR%/
mkdir -p /tmp/%FIFO_DIR%/fifo/
mkdir /tmp/%FIFO_DIR%/fifo/full_correlation/
mkdir work/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryleccalc

mkfifo /tmp/%FIFO_DIR%/fifo/gul_P1

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1.idx

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P1

mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P1
mkfifo /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P1.idx



# --- Do ground up loss computes ---



tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1 work/gul_S1_summaryleccalc/P1.bin > /dev/null & pid1=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1.idx work/gul_S1_summaryleccalc/P1.idx > /dev/null & pid2=$!

summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P1 < /tmp/%FIFO_DIR%/fifo/gul_P1 &

# --- Do ground up loss computes ---



tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P1 work/full_correlation/gul_S1_summaryleccalc/P1.bin > /dev/null & pid3=$!
tee < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P1.idx work/full_correlation/gul_S1_summaryleccalc/P1.idx > /dev/null & pid4=$!

summarycalc -m -i  -1 /tmp/%FIFO_DIR%/fifo/full_correlation/gul_S1_summary_P1 < /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P1 &

eve 1 20 | getmodel | gulcalc -S100 -L100 -r -j /tmp/%FIFO_DIR%/fifo/full_correlation/gul_P1 -a1 -i - > /tmp/%FIFO_DIR%/fifo/gul_P1  &

wait $pid1 $pid2 $pid3 $pid4


# --- Do ground up loss kats ---


# --- Do ground up loss kats for fully correlated output ---

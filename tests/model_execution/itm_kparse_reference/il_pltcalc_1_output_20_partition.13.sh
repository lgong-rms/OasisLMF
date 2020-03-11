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


mkfifo fifo/il_P14

mkfifo fifo/il_S1_summary_P14
mkfifo fifo/il_S1_summarypltcalc_P14
mkfifo fifo/il_S1_pltcalc_P14



# --- Do insured loss computes ---
pltcalc -s < fifo/il_S1_summarypltcalc_P14 > work/kat/il_S1_pltcalc_P14 & pid1=$!
tee < fifo/il_S1_summary_P14 fifo/il_S1_summarypltcalc_P14 > /dev/null & pid2=$!
summarycalc -f  -1 fifo/il_S1_summary_P14 < fifo/il_P14 &

eve 14 20 | getmodel | gulcalc -S100 -L100 -r -a1 -i - | fmcalc -a2 > fifo/il_P14  &

wait $pid1 $pid2


# --- Do insured loss kats ---

kat work/kat/il_S1_pltcalc_P14 > output/il_S1_pltcalc.csv & kpid1=$!
wait $kpid1


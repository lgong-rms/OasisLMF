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
mkdir work/gul_S1_summaryaalcalc
mkdir work/gul_S2_summaryleccalc
mkdir work/gul_S2_summaryaalcalc
mkdir work/full_correlation/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryaalcalc
mkdir work/full_correlation/gul_S2_summaryleccalc
mkdir work/full_correlation/gul_S2_summaryaalcalc

mkfifo /tmp/%FIFO_DIR%/fifo/gul_P2

mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summaryeltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarysummarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_summarypltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S1_pltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summaryeltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_eltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarysummarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarycalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_summarypltcalc_P2
mkfifo /tmp/%FIFO_DIR%/fifo/gul_S2_pltcalc_P2

mkfifo gul_S1_summary_P2
mkfifo gul_S1_summaryeltcalc_P2
mkfifo gul_S1_eltcalc_P2
mkfifo gul_S1_summarysummarycalc_P2
mkfifo gul_S1_summarycalc_P2
mkfifo gul_S1_summarypltcalc_P2
mkfifo gul_S1_pltcalc_P2
mkfifo gul_S2_summary_P2
mkfifo gul_S2_summaryeltcalc_P2
mkfifo gul_S2_eltcalc_P2
mkfifo gul_S2_summarysummarycalc_P2
mkfifo gul_S2_summarycalc_P2
mkfifo gul_S2_summarypltcalc_P2
mkfifo gul_S2_pltcalc_P2



# --- Do ground up loss computes ---
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summaryeltcalc_P2 > work/kat/gul_S1_eltcalc_P2 & pid1=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarysummarycalc_P2 > work/kat/gul_S1_summarycalc_P2 & pid2=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S1_summarypltcalc_P2 > work/kat/gul_S1_pltcalc_P2 & pid3=$!
eltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summaryeltcalc_P2 > work/kat/gul_S2_eltcalc_P2 & pid4=$!
summarycalctocsv -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarysummarycalc_P2 > work/kat/gul_S2_summarycalc_P2 & pid5=$!
pltcalc -s < /tmp/%FIFO_DIR%/fifo/gul_S2_summarypltcalc_P2 > work/kat/gul_S2_pltcalc_P2 & pid6=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_summaryeltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_summarypltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S1_summarysummarycalc_P2 work/gul_S1_summaryaalcalc/P2.bin work/gul_S1_summaryleccalc/P2.bin > /dev/null & pid7=$!
tee < /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_summaryeltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_summarypltcalc_P2 /tmp/%FIFO_DIR%/fifo/gul_S2_summarysummarycalc_P2 work/gul_S2_summaryaalcalc/P2.bin work/gul_S2_summaryleccalc/P2.bin > /dev/null & pid8=$!
summarycalc -i  -1 /tmp/%FIFO_DIR%/fifo/gul_S1_summary_P2 -2 /tmp/%FIFO_DIR%/fifo/gul_S2_summary_P2 < /tmp/%FIFO_DIR%/fifo/gul_P2 &

eve 2 2 | getmodel | gulcalc -S0 -L0 -r -j gul_P2 -a1 -i - > /tmp/%FIFO_DIR%/fifo/gul_P2  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8

# --- Do computes for fully correlated output ---



# --- Do ground up loss computes ---
eltcalc -s < gul_S1_summaryeltcalc_P2 > work/full_correlation/kat/gul_S1_eltcalc_P2 & pid1=$!
summarycalctocsv -s < gul_S1_summarysummarycalc_P2 > work/full_correlation/kat/gul_S1_summarycalc_P2 & pid2=$!
pltcalc -s < gul_S1_summarypltcalc_P2 > work/full_correlation/kat/gul_S1_pltcalc_P2 & pid3=$!
eltcalc -s < gul_S2_summaryeltcalc_P2 > work/full_correlation/kat/gul_S2_eltcalc_P2 & pid4=$!
summarycalctocsv -s < gul_S2_summarysummarycalc_P2 > work/full_correlation/kat/gul_S2_summarycalc_P2 & pid5=$!
pltcalc -s < gul_S2_summarypltcalc_P2 > work/full_correlation/kat/gul_S2_pltcalc_P2 & pid6=$!
tee < gul_S1_summary_P2 gul_S1_summaryeltcalc_P2 gul_S1_summarypltcalc_P2 gul_S1_summarysummarycalc_P2 work/full_correlation/gul_S1_summaryaalcalc/P2.bin work/full_correlation/gul_S1_summaryleccalc/P2.bin > /dev/null & pid7=$!
tee < gul_S2_summary_P2 gul_S2_summaryeltcalc_P2 gul_S2_summarypltcalc_P2 gul_S2_summarysummarycalc_P2 work/full_correlation/gul_S2_summaryaalcalc/P2.bin work/full_correlation/gul_S2_summaryleccalc/P2.bin > /dev/null & pid8=$!
summarycalc -i  -1 gul_S1_summary_P2 -2 gul_S2_summary_P2 < gul_P2 &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8


# --- Do ground up loss kats ---

kat work/kat/gul_S1_eltcalc_P2 > output/gul_S1_eltcalc.csv & kpid1=$!
kat work/kat/gul_S1_pltcalc_P2 > output/gul_S1_pltcalc.csv & kpid2=$!
kat work/kat/gul_S1_summarycalc_P2 > output/gul_S1_summarycalc.csv & kpid3=$!
kat work/kat/gul_S2_eltcalc_P2 > output/gul_S2_eltcalc.csv & kpid4=$!
kat work/kat/gul_S2_pltcalc_P2 > output/gul_S2_pltcalc.csv & kpid5=$!
kat work/kat/gul_S2_summarycalc_P2 > output/gul_S2_summarycalc.csv & kpid6=$!

# --- Do ground up loss kats for fully correlated output ---

kat work/full_correlation/kat/gul_S1_eltcalc_P2 > output/full_correlation/gul_S1_eltcalc.csv & kpid7=$!
kat work/full_correlation/kat/gul_S1_pltcalc_P2 > output/full_correlation/gul_S1_pltcalc.csv & kpid8=$!
kat work/full_correlation/kat/gul_S1_summarycalc_P2 > output/full_correlation/gul_S1_summarycalc.csv & kpid9=$!
kat work/full_correlation/kat/gul_S2_eltcalc_P2 > output/full_correlation/gul_S2_eltcalc.csv & kpid10=$!
kat work/full_correlation/kat/gul_S2_pltcalc_P2 > output/full_correlation/gul_S2_pltcalc.csv & kpid11=$!
kat work/full_correlation/kat/gul_S2_summarycalc_P2 > output/full_correlation/gul_S2_summarycalc.csv & kpid12=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6 $kpid7 $kpid8 $kpid9 $kpid10 $kpid11 $kpid12


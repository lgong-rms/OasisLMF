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

rm -R -f fifo/*
mkdir fifo/full_correlation/
rm -R -f work/*
mkdir work/kat/
mkdir work/full_correlation/
mkdir work/full_correlation/kat/

mkdir work/gul_S1_summaryleccalc
mkdir work/gul_S1_summaryaalcalc
mkdir work/full_correlation/gul_S1_summaryleccalc
mkdir work/full_correlation/gul_S1_summaryaalcalc
mkdir work/il_S1_summaryleccalc
mkdir work/il_S1_summaryaalcalc
mkdir work/full_correlation/il_S1_summaryleccalc
mkdir work/full_correlation/il_S1_summaryaalcalc

mkfifo fifo/full_correlation/gul_fc_P38

mkfifo fifo/gul_P38

mkfifo fifo/gul_S1_summary_P38
mkfifo fifo/gul_S1_summary_P38.idx
mkfifo fifo/gul_S1_eltcalc_P38
mkfifo fifo/gul_S1_summarycalc_P38
mkfifo fifo/gul_S1_pltcalc_P38

mkfifo fifo/il_P38

mkfifo fifo/il_S1_summary_P38
mkfifo fifo/il_S1_summary_P38.idx
mkfifo fifo/il_S1_eltcalc_P38
mkfifo fifo/il_S1_summarycalc_P38
mkfifo fifo/il_S1_pltcalc_P38

mkfifo fifo/full_correlation/gul_P38

mkfifo fifo/full_correlation/gul_S1_summary_P38
mkfifo fifo/full_correlation/gul_S1_summary_P38.idx
mkfifo fifo/full_correlation/gul_S1_eltcalc_P38
mkfifo fifo/full_correlation/gul_S1_summarycalc_P38
mkfifo fifo/full_correlation/gul_S1_pltcalc_P38

mkfifo fifo/full_correlation/il_P38

mkfifo fifo/full_correlation/il_S1_summary_P38
mkfifo fifo/full_correlation/il_S1_summary_P38.idx
mkfifo fifo/full_correlation/il_S1_eltcalc_P38
mkfifo fifo/full_correlation/il_S1_summarycalc_P38
mkfifo fifo/full_correlation/il_S1_pltcalc_P38



# --- Do insured loss computes ---
eltcalc -s < fifo/il_S1_eltcalc_P38 > work/kat/il_S1_eltcalc_P38 & pid1=$!
summarycalctocsv -s < fifo/il_S1_summarycalc_P38 > work/kat/il_S1_summarycalc_P38 & pid2=$!
pltcalc -s < fifo/il_S1_pltcalc_P38 > work/kat/il_S1_pltcalc_P38 & pid3=$!
tee < fifo/il_S1_summary_P38 fifo/il_S1_eltcalc_P38 fifo/il_S1_summarycalc_P38 fifo/il_S1_pltcalc_P38 work/il_S1_summaryaalcalc/P38.bin work/il_S1_summaryleccalc/P38.bin > /dev/null & pid4=$!
tee < fifo/il_S1_summary_P38.idx work/il_S1_summaryleccalc/P38.idx > /dev/null & pid5=$!
summarycalc -m -f  -1 fifo/il_S1_summary_P38 < fifo/il_P38 &

# --- Do ground up loss computes ---
eltcalc -s < fifo/gul_S1_eltcalc_P38 > work/kat/gul_S1_eltcalc_P38 & pid6=$!
summarycalctocsv -s < fifo/gul_S1_summarycalc_P38 > work/kat/gul_S1_summarycalc_P38 & pid7=$!
pltcalc -s < fifo/gul_S1_pltcalc_P38 > work/kat/gul_S1_pltcalc_P38 & pid8=$!
tee < fifo/gul_S1_summary_P38 fifo/gul_S1_eltcalc_P38 fifo/gul_S1_summarycalc_P38 fifo/gul_S1_pltcalc_P38 work/gul_S1_summaryaalcalc/P38.bin work/gul_S1_summaryleccalc/P38.bin > /dev/null & pid9=$!
tee < fifo/gul_S1_summary_P38.idx work/gul_S1_summaryleccalc/P38.idx > /dev/null & pid10=$!
summarycalc -m -i  -1 fifo/gul_S1_summary_P38 < fifo/gul_P38 &

# --- Do insured loss computes ---
eltcalc -s < fifo/full_correlation/il_S1_eltcalc_P38 > work/full_correlation/kat/il_S1_eltcalc_P38 & pid11=$!
summarycalctocsv -s < fifo/full_correlation/il_S1_summarycalc_P38 > work/full_correlation/kat/il_S1_summarycalc_P38 & pid12=$!
pltcalc -s < fifo/full_correlation/il_S1_pltcalc_P38 > work/full_correlation/kat/il_S1_pltcalc_P38 & pid13=$!
tee < fifo/full_correlation/il_S1_summary_P38 fifo/full_correlation/il_S1_eltcalc_P38 fifo/full_correlation/il_S1_summarycalc_P38 fifo/full_correlation/il_S1_pltcalc_P38 work/full_correlation/il_S1_summaryaalcalc/P38.bin work/full_correlation/il_S1_summaryleccalc/P38.bin > /dev/null & pid14=$!
tee < fifo/full_correlation/il_S1_summary_P38.idx work/full_correlation/il_S1_summaryleccalc/P38.idx > /dev/null & pid15=$!
summarycalc -m -f  -1 fifo/full_correlation/il_S1_summary_P38 < fifo/full_correlation/il_P38 &

# --- Do ground up loss computes ---
eltcalc -s < fifo/full_correlation/gul_S1_eltcalc_P38 > work/full_correlation/kat/gul_S1_eltcalc_P38 & pid16=$!
summarycalctocsv -s < fifo/full_correlation/gul_S1_summarycalc_P38 > work/full_correlation/kat/gul_S1_summarycalc_P38 & pid17=$!
pltcalc -s < fifo/full_correlation/gul_S1_pltcalc_P38 > work/full_correlation/kat/gul_S1_pltcalc_P38 & pid18=$!
tee < fifo/full_correlation/gul_S1_summary_P38 fifo/full_correlation/gul_S1_eltcalc_P38 fifo/full_correlation/gul_S1_summarycalc_P38 fifo/full_correlation/gul_S1_pltcalc_P38 work/full_correlation/gul_S1_summaryaalcalc/P38.bin work/full_correlation/gul_S1_summaryleccalc/P38.bin > /dev/null & pid19=$!
tee < fifo/full_correlation/gul_S1_summary_P38.idx work/full_correlation/gul_S1_summaryleccalc/P38.idx > /dev/null & pid20=$!
summarycalc -m -i  -1 fifo/full_correlation/gul_S1_summary_P38 < fifo/full_correlation/gul_P38 &

tee < fifo/full_correlation/gul_fc_P38 fifo/full_correlation/gul_P38  | fmcalc -a2 > fifo/full_correlation/il_P38  &
eve 38 40 | getmodel | gulcalc -S100 -L100 -r -j fifo/full_correlation/gul_fc_P38 -a1 -i - | tee fifo/gul_P38 | fmcalc -a2 > fifo/il_P38  &

wait $pid1 $pid2 $pid3 $pid4 $pid5 $pid6 $pid7 $pid8 $pid9 $pid10 $pid11 $pid12 $pid13 $pid14 $pid15 $pid16 $pid17 $pid18 $pid19 $pid20


# --- Do insured loss kats ---

kat -s work/kat/il_S1_eltcalc_P38 > output/il_S1_eltcalc.csv & kpid1=$!
kat work/kat/il_S1_pltcalc_P38 > output/il_S1_pltcalc.csv & kpid2=$!
kat work/kat/il_S1_summarycalc_P38 > output/il_S1_summarycalc.csv & kpid3=$!

# --- Do insured loss kats for fully correlated output ---

kat -s work/full_correlation/kat/il_S1_eltcalc_P38 > output/full_correlation/il_S1_eltcalc.csv & kpid4=$!
kat work/full_correlation/kat/il_S1_pltcalc_P38 > output/full_correlation/il_S1_pltcalc.csv & kpid5=$!
kat work/full_correlation/kat/il_S1_summarycalc_P38 > output/full_correlation/il_S1_summarycalc.csv & kpid6=$!

# --- Do ground up loss kats ---

kat -s work/kat/gul_S1_eltcalc_P38 > output/gul_S1_eltcalc.csv & kpid7=$!
kat work/kat/gul_S1_pltcalc_P38 > output/gul_S1_pltcalc.csv & kpid8=$!
kat work/kat/gul_S1_summarycalc_P38 > output/gul_S1_summarycalc.csv & kpid9=$!

# --- Do ground up loss kats for fully correlated output ---

kat -s work/full_correlation/kat/gul_S1_eltcalc_P38 > output/full_correlation/gul_S1_eltcalc.csv & kpid10=$!
kat work/full_correlation/kat/gul_S1_pltcalc_P38 > output/full_correlation/gul_S1_pltcalc.csv & kpid11=$!
kat work/full_correlation/kat/gul_S1_summarycalc_P38 > output/full_correlation/gul_S1_summarycalc.csv & kpid12=$!
wait $kpid1 $kpid2 $kpid3 $kpid4 $kpid5 $kpid6 $kpid7 $kpid8 $kpid9 $kpid10 $kpid11 $kpid12

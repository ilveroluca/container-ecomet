#!/bin/bash

# Check parameters
if [[ $# -lt 10 ]]; then
	print "Error! 10 Arguments required."
	print "Usage: \$0 input.zip polarity study.dir study.maf qc.dir qc.maf traits.txt phylo.tre a.txt s.txt"
	exit 1
fi

# Input parameters
INPUT="${1}"
POLARITY="${2}"

# Output parameters
STUDY_FILES="${3}"
STUDY_MAF="${4}"
QC_FILES="${5}"
QC_MAF="${6}"
TRAITS_FILE="${7}"
PHYLO_FILE="${8}"
A_FILE="${9}"
S_FILE="${10}"

# Unzip whole dataset
mkdir output || exit 2
unzip -d output ${INPUT} || exit 1

# Create output files and folders (for dataset collections)
mkdir -p ${STUDY_FILES} || exit 3
touch ${STUDY_MAF} || exit 4
mkdir -p ${QC_FILES} || exit 5
touch ${QC_MAF} || exit 6
touch ${TRAITS_FILE} || exit 7
touch ${PHYLO_FILE} || exit 8
touch ${A_FILE} || exit 9
touch ${S_FILE} || exit 10

# Move files to their places
mv output/${POLARITY}_MM8_*.mzML ${QC_FILES}/
mv output/${POLARITY}_[0-9]*.mzML ${STUDY_FILES}/
mv output/m_*_profiling_*${POLARITY}*.maf ${STUDY_MAF}
mv output/m_*_quality_control_*${POLARITY}*.maf ${QC_MAF}
mv output/a_*${POLARITY}*.txt ${A_FILE}
mv output/s_*.txt ${S_FILE}
mv output/${TRAITS_FILE} 
mv output/${PHYLO_FILE}


#!/bin/bash
set -xe

SIDE="$1"

BOARD="nice_nano_v2"
BASE_SHIELD="kyria_rev2"

export HOME="${PWD}/home"
mkdir -p ${HOME}

# west init -l config
west update
west zephyr-export

function build_side {
    SIDE=$1
    OUTDIR="out/${SIDE}"
    SHIELD="${BASE_SHIELD}_${SIDE}"

    west build --pristine -s zmk/app -b ${BOARD} -- -DZMK_CONFIG="${PWD}/config" -DSHIELD=${SHIELD}

    # Copy the build result to out dir
    rm -rf ${OUTDIR} && mkdir -p ${OUTDIR}
    cp build/zephyr/*.uf2 ${OUTDIR}
    grep -v -e "^#" -e "^$" build/zephyr/.config | sort > ${OUTDIR}/Kconfig
}

build_side left
build_side right

#!/bin/sh
# Horodatage de tous les artefacts — execute apres genimage
# Un seul timestamp commun pour tous les fichiers
TS=$(date -u +"%Y%m%d_%H%M%S")

cp ${BINARIES_DIR}/sdcard.img \
   ${BINARIES_DIR}/sdcard_${TS}.img

cp ${BINARIES_DIR}/zImage \
   ${BINARIES_DIR}/zImage_${TS}

cp ${BINARIES_DIR}/at91-sama5d3_ksz9477_evb.dtb \
   ${BINARIES_DIR}/at91-sama5d3_ksz9477_evb_${TS}.dtb

echo "post-genimage: artefacts horodates : ${TS}"

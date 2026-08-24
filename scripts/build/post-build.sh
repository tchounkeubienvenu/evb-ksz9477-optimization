#!/bin/sh
# Copier le DTB EVB-KSZ9477 sous le nom attendu par U-Boot
cp ${BINARIES_DIR}/at91-sama5d3_ksz9477_evb.dtb \
   ${BINARIES_DIR}/at91-sama5d3_xplained.dtb
echo "post-build: DTB copie sous at91-sama5d3_xplained.dtb"

# Forcer la regeneration de boot.vfat par genimage
rm -f ${BINARIES_DIR}/boot.vfat
echo "post-build: boot.vfat supprime pour forcer regeneration"

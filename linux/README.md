## Linux Kernel — Modifications noyau 6.6.18 LTS

**Ce dossier contient les modifications apportées au noyau Linux 6.6.18. :**
```bash
patches/0001-evb-ksz9477-optimize-dts.patch
configs/linux-ksz9477.config
```

**Voici un résumé des améliorations apportées au DTS original :**
- `spi-max-frequency` : 1 MHz → 22 MHz
- `local-mac-address` : MAC stable 00:10:a1:94:77:01
- `interrupt-parent/interrupts` : IRQ matérielle PIOB 28
- `Adresse MAC unique par port DSA` : lan1= 00:10:a1:94:77:02 ... lan5= 00:10:a1:94:77:06

# État original du système (AUCUNE MODIFICATION FAITE)

Ce répertoire contient les fichiers de configuration tels que fournis
par le fabricant Microchip et par Buildroot, AVANT toute modification.

## Contenu

### linux/dts/at91-sama5d3_ksz9477_evb.dts
C'est le Device Tree Source officiel que nous avons extrait de linux-6.6.18 :

```bash
cd /tmp
git clone --depth 1 --branch v6.6.18 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.6.18
```

Chemin dans linux-6.6.18 : `linux-6.6.18/arch/arm/boot/dts/at91-sama5d3_ksz9477_evb.dts`

### linux/config/sama5_defconfig

C'est le fichier de configuration officiel du noyau Linux pour la carte SAMA5D36.

### buildroot/atmel_sama5d3_xplained_mmc_defconfig

C'est le Defconfig Buildroot officiel pour la carte SAMA5D36,
tel que livré dans Buildroot 2024.02. C'est lui que nous utiliserons comme point de départ 
pour notre defconfig personnalisé evb_ksz9477_defconfig.

Chemin dans buildroot : `buildroot/configs/atmel_sama5d3_xplained_mmc_defconfig`

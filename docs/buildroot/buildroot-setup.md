# Configuration Buildroot pour EVB-KSZ9477S

## Contexte

Ce répertoire contient la configuration complète de Buildroot 2024.02
permettant de compiler notre système Linux embarqué optimisé pour la
carte EVB-KSZ9477S.

## Point de départ

### Defconfig Buildroot
Notre `evb_ksz9477_defconfig` est dérivé du defconfig officiel
Buildroot `atmel_sama5d3_xplained_mmc_defconfig` (disponible dans
`original-state/buildroot/`), auquel nous avons apporté les
personnalisations suivantes :
- Hostname : EVB-KSZ9477
- Noyau Linux 6.6.18 LTS avec config et patch personnalisés
- Toolchain Bootlin armv7-eabihf glibc stable 2023.11-1
- Packages réseau additionnels
- Scripts post-build et post-genimage personnalisés

### Config noyau Linux
Notre `linux-ksz9477.config` est dérivé du defconfig officiel
Microchip `sama5_defconfig` (disponible dans
`original-state/linux/config/`), auquel nous avons ajouté :
- CONFIG_NET_DSA=y (framework DSA)
- CONFIG_NET_DSA_MICROCHIP_KSZ9477=y (driver KSZ9477S)
- CONFIG_BRIDGE=y (bridge Ethernet)
- CONFIG_BRIDGE_NETFILTER=y
- Et toutes les dépendances associées

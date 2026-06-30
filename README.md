## Structure du dépôt
## Rôle de chaque répertoire

### `original-state/`

Contient les fichiers de configuration **officiels**, tels que
livrés par Microchip Technology et Buildroot, **sans aucune
modification** de notre part. C'est le point de référence qui
permet de mesurer et de comprendre précisément chaque optimisation
apportée par ce projet.

| Fichier | Origine | Rôle |
|---|---|---|
| `buildroot/atmel_sama5d3_xplained_mmc_defconfig` | Buildroot 2024.02 | Defconfig officiel pour la carte SAMA5D3 Xplained |
| `linux/config/sama5_defconfig` | linux-6.6.18/arch/arm/configs/ | Defconfig noyau officiel Microchip/Atmel pour la famille SAMA5 |
| `linux/dts/at91-sama5d3_ksz9477_evb.dts` | linux-6.6.18/arch/arm/boot/dts/microchip/ | Device Tree Source officiel pour l'EVB-KSZ9477S |

Voir `original-state/README.md` pour les détails d'extraction de
chaque fichier.

### `buildroot/configs/`

Contient `evb_ksz9477_defconfig`, notre configuration Buildroot
personnalisée, dérivée de
`original-state/buildroot/atmel_sama5d3_xplained_mmc_defconfig`.

### `linux/configs/`

Contient `linux-ksz9477.config`, notre configuration noyau
complète, dérivée de `original-state/linux/config/sama5_defconfig`.

### `linux/dts/`

Contient `at91-sama5d3_ksz9477_evb.dts`, notre Device Tree Source
complet, dérivé de
`original-state/linux/dts/at91-sama5d3_ksz9477_evb.dts`.

# EVB-KSZ9477S — Optimisation du switch Ethernet Gigabit

![Name](https://img.shields.io/badge/Name-Bienvenu%20Tchounkeu-green.svg)
![Date](https://img.shields.io/badge/Date-2026-brightgreen.svg)

## Description

Ce dépôt documente l'optimisation du switch Ethernet Gigabit
**Microchip KSZ9477S** sur la carte d'évaluation **EVB-KSZ9477S**
(CPU ATMEL SAMA5D36A, ARM Cortex-A5), via un système Linux embarqué
customisé avec Buildroot.

---

## Rôle de chaque répertoire

### `original-state/`

C'est ici que sont les fichiers de configuration **officiels**, tels que livrés par
Microchip Technology et Buildroot, **sans aucune modification**.
C'est notre point de référence permettant de comparer ligne par ligne chaque
optimisation apportée par notre projet.

| Fichier | Origine |
|---|---|
| `buildroot/atmel_sama5d3_xplained_mmc_defconfig` | Buildroot 2024.02 |
| `linux/config/sama5_defconfig` | linux-6.6.18/arch/arm/configs/ |
| `linux/dts/at91-sama5d3_ksz9477_evb.dts` | linux-6.6.18/arch/arm/boot/dts/microchip/ |

Voir `original-state/README.md` pour les détails d'extraction.

### `buildroot/`

C'est la configuration Buildroot complète pour compiler notre système optimisé.
`configs/evb_ksz9477_defconfig` est dérivé de l'officiel
`atmel_sama5d3_xplained_mmc_defconfig` (voir `original-state/`).

### `linux/`

- `configs/linux-ksz9477.config` : configuration noyau, dérivée
  de `sama5_defconfig`. Dans lequel nous avons fait nos ajouts.
- `dts/at91-sama5d3_ksz9477_evb.dts` : Device Tree Source complet.
  Voir `docs/dts-changes/` pour le détail de chaque modification.
- `patches/0001-evb-ksz9477-optimize-dts.patch` : patch équivalent
  du DTS modifié.

### `scripts/`

- `build/post-build.sh` : renomme le DTB pour U-Boot (`at91-sama5d3_xplained.dtb`).
- `build/post-genimage.sh` : horodate les artefacts de build pour la traçabilité
- `init/S50switch` : script d’initialisation minimaliste qui démarre l’interface 
   loopback et leve le port CPU (eth0) du switch.

### `docs/`

Documentation technique détaillée de chaque optimisation.

---

## Instructions de build

### 1. Préparer l'environnement

```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential git bison flex libssl-dev \
    libncurses-dev wget unzip python3 cpio rsync bc \
    file device-tree-compiler
```

### 2. Cloner ce dépôt

```bash
git clone https://github.com/unetsn/evb-ksz9477-optimization.git
cd evb-ksz9477-optimization
```

### 3. Cloner Buildroot 2024.02

```bash
# IMPORTANT : cloner dans buildroot-src pour éviter la collision
# avec le répertoire buildroot/ du dépôt

git clone https://github.com/buildroot/buildroot.git \
    buildroot-src
cd buildroot-src
git checkout 2024.02
```

### 4. Copier les fichiers du projet

```bash

cp ../buildroot/configs/evb_ksz9477_defconfig \
   ./configs/

mkdir -p ./board/microchip/evb-ksz9477

cp ../buildroot/board/microchip/evb-ksz9477/genimage.cfg \
   ./board/microchip/evb-ksz9477/
cp ../linux/configs/linux-ksz9477.config \
   ./board/microchip/evb-ksz9477/
cp ../linux/patches/0001-evb-ksz9477-optimize-dts.patch \
   ./board/microchip/evb-ksz9477/
cp ../scripts/build/post-build.sh \
   ./board/microchip/evb-ksz9477/
cp ../scripts/build/post-genimage.sh \
   ./board/microchip/evb-ksz9477/

mkdir -p ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d
cp ../buildroot/rootfs-overlay/etc/fstab \
   ./board/microchip/evb-ksz9477/rootfs-overlay/etc/
cp ../scripts/init/S50switch \
   ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d/

chmod +x ./board/microchip/evb-ksz9477/post-build.sh
chmod +x ./board/microchip/evb-ksz9477/post-genimage.sh
chmod +x ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d/S50switch
```

### 5. Charger le defconfig et compiler

```bash
Depuis le repertoire buildroot-src :
make evb_ksz9477_defconfig
make
```

### 6. Flasher la microSD

```bash
sudo dd if=output/images/sdcard.img of=/dev/sdX \
    bs=4M status=progress conv=fsync && sync

```

### 7. Connexion série (J10, 115200 bauds)
Établir une connection serie et demarrer l'EVB.
Login    : root
Password : root

---

## Validation

- Image produite : `sdcard.img` (117 Mo)
- Le switch KSZ9477S est détecté (Chip ID `0x00947700`)
- DSA opérationnel : les interfaces lan1 à lan5 sont présentes 
  avec des MACs uniques

---

## Auteur

**Bienvenu Tchounkeu N.**
Stage GEI1096-00 — UQTR — Été 2026
Superviseur : Prof. Miloud Bagaa
Encadreur : Abderrahmane Boulahdour

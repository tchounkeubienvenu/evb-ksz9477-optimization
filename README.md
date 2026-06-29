# EVB-KSZ9477S — Optimisation du switch Ethernet Gigabit

![Name](https://img.shields.io/badge/Name-Bienvenu%20Tchounkeu.bienvenu-green.svg)
![Date](https://img.shields.io/badge/Date-2026-brightgreen.svg)

## Description

Ce dépôt contient les fichiers de customisation Buildroot pour l'optimisation
du switch Ethernet Gigabit **Microchip KSZ9477S** sur la carte d'évaluation
**EVB-KSZ9477S**.

Projet réalisé dans le cadre du stage **GEI1096-00 — Génie informatique**
à l'**UQTR (Université du Québec à Trois-Rivières)**, Été 2026.

---

## Contenu du dépôt

| Dossier | Fichier | Description |
|---------|---------|-------------|
| `buildroot/configs/` | `evb_ksz9477_defconfig` | Configuration complète Buildroot 2024.02 |
| `buildroot/board/microchip/evb-ksz9477/` | `genimage.cfg` | Layout partition SD (FAT boot + ext4 rootfs) |
| `buildroot/rootfs-overlay/etc/` | `fstab` | Montage tmpfs corrigé |
| `linux/patches/` | `0001-evb-ksz9477-optimize-dts.patch` | Patch DTS optimisé |
| `linux/configs/` | `linux-ksz9477.config` | Configuration noyau Linux 6.6.18 LTS |
| `scripts/build/` | `post-build.sh` | Script pre-genimage |
| `scripts/build/` | `post-genimage.sh` | Horodatage des artefacts |
| `scripts/init/` | `S50switch` | Init switch DSA au démarrage |

---

## Instructions de build

### 1. Préparez l'environnement

```bash
sudo apt-get update
sudo apt-get install -y \
    build-essential git bison flex libssl-dev \
    libncurses-dev wget unzip python3 cpio rsync bc \
    file device-tree-compiler
```

### 2. Cloner ce dépôt Github

```bash
git clone https://github.com/unetsn/evb-ksz9477-optimization.git
cd evb-ksz9477-optimization
```

### 3. Télécharger Buildroot

```bash
git clone https://github.com/buildroot/buildroot.git buildroot/buildroot
cd buildroot/buildroot
git checkout 2024.02
```


### 4. Appliquer les configurations

#### a. Configuration de Buildroot 

```bash
cp ../configs/evb_ksz9477_defconfig \
   ./configs/evb_ksz9477_defconfig

mkdir -p ./board/microchip/evb-ksz9477

cp ../board/microchip/evb-ksz9477/genimage.cfg \
   ./board/microchip/evb-ksz9477/genimage.cfg

mkdir -p ./board/microchip/evb-ksz9477/rootfs-overlay/etc

cp ../rootfs-overlay/etc/fstab \
   ./board/microchip/evb-ksz9477/rootfs-overlay/etc/fstab
```

#### b. Configuration du noyau Linux

```bash
cp ../../linux/configs/linux-ksz9477.config \
   ./board/microchip/evb-ksz9477/linux-ksz9477.config

cp ../../linux/patches/0001-evb-ksz9477-optimize-dts.patch \
   ./board/microchip/evb-ksz9477/0001-evb-ksz9477-optimize-dts.patch
```

#### c. Scripts de post-build et post-genimage

```bash
cp ../../scripts/build/post-build.sh \
   ./board/microchip/evb-ksz9477/post-build.sh
cp ../../scripts/build/post-genimage.sh \
   ./board/microchip/evb-ksz9477/post-genimage.sh

chmod +x ./board/microchip/evb-ksz9477/post-build.sh
chmod +x ./board/microchip/evb-ksz9477/post-genimage.sh
```

#### d. Script d'initialisation S50switch

```bash
mkdir -p ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d
cp ../../scripts/init/S50switch \
   ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d/S50switch
chmod +x ./board/microchip/evb-ksz9477/rootfs-overlay/etc/init.d/S50switch
```

### 5. Charger le defconfig et compiler

```bash
make evb_ksz9477_defconfig

make
```

### 6. Flasher

Flashez `output/images/sdcard_YYYYMMDD_HHMMSS.img` sur une carte microSD.

---

### 7. Login and password

```bash
Login : root
Password : root
```



---

## Auteur

**Bienvenu Tchounkeu N.**
Stage GEI1096-00 — UQTR — Été 2026
Superviseur : Prof. Miloud Bagaa
 | 
Encadreur : Abderrahmane Boulahdour

# Optimisation de la fréquence SPI du KSZ9477S

## Problème identifié

Le Device Tree Source (DTS) officiel Microchip configure le bus SPI
vers le KSZ9477S par défaut à 1 MHz (`spi-max-frequency = <1000000>`).
Cette valeur très basse ralentit inutilement les transferts
SPI.

## Tests effectués

| Fréquence  | Diviseur (132 MHz) | Résultat                           |
|------------|--------------------|------------------------------------|
| 1 MHz      | /132               | ✅ Fonctionnel (valeur d'origine)  |
| 8 MHz      | /16.5              | ✅ Fonctionnel                     |
| 16.5 MHz   | /8                 | ✅ Fonctionnel                     |
| **22 MHz** | **/6**             | ✅ **Fonctionnel — RETENU**        |
| 26.4 MHz   | /5                 | ❌ Non fonctionnel                 |
| 30 MHz     | /4.4               | ❌ Non fonctionnel                 |
| 33 MHz     | /4                 | ❌ Non fonctionnel                 |
| 40 MHz     | /3.3               | ❌ Non fonctionnel                 |
| 44 MHz     | /3                 | ❌ Non fonctionnel                 |


## Modification apportée

**Le fichier modifié est : **
```bash
~/evb-ksz9477-optimization/buildroot/board/microchip/evb-ksz9477
configs/linux-ksz9477.config
```

**Nous avons remplacé `spi-max-frequency = <1000000>` par `spi-max-frequency = <22000000>`**

## Critère de validation

Après avoir booté la carte avec l'image obtenue avec `spi-max-frequency = <22000000>`,
nous avons utilisé les commandes suivantes pour vérifier le bon fonctionnement :

# Commande 1

```bash
dmesg | grep "found switch"
```
RESULTAT : `ksz-switch spi1.0: found switch: KSZ9477, rev 0` --> Le switch est bien détecté ✅

# Commande 2

```bash
ip a s
```
RESULTAT : interfaces lan1 jusqu'a lan5 présentes avec MACs uniques --> Le DSA est opérationnel ✅

# Commande 3

```bash
`cat /proc/device-tree/ahb/apb/spi@f8008000/switch@0/spi-max-frequency | xxd`
```
RESULTAT : `014f b180` = 0x014FB180 = 22 000 000 Hz = 22 MHz ✅ --> C'est la fréquence la fréquence que nous avons configurée.

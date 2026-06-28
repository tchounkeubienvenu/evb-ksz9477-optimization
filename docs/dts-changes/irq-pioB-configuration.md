# Configuration de l'interruption matérielle (IRQ) du KSZ9477S

## Problème identifié

Le DTS officiel Microchip ne contient aucune configuration
d'interruption pour le nœud switch@0 — la broche INTRP_N
n'est pas déclarée, ce qui force le driver ksz9477 à fonctionner
en mode polling (scrutation périodique des registres).

## Configuration retenue

Après analyse du schéma électrique de l'EVB (feuille 4) :
- Signal INTRP_N connecté à PioB, broche 28
- Actif bas (active-low), conformément à la logique open-drain

`Nous avons donc ajouté au divice tree ce qui suit : `

```dts
interrupt-parent = <&pioB>;
interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
```

## Validation

- Le switch est détecté : `ksz-switch spi1.0: found switch: KSZ9477, rev 0`
- Driver ksz9477 démarre sans erreur IRQ
- Mais les PHY des ports lan1-lan5 fonctionnent toujours en mode polling (`irq=POLL`)

## Limitation — Linux 6.6.18

Sous Linux 6.6.18, les PHY des ports lan1-lan5 fonctionnent
en mode polling (`irq=POLL`) malgré la configuration DTS correcte.

Nous pourons upgrader notre système pour un noyau linux plus récent 
plus tard, par exemple le Linux 6.18.37.

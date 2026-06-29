# Adresses MAC uniques par port DSA du KSZ9477S

## Problème identifié

Le DTS officiel Microchip ne définit pas les adresses MAC fixes 
individuelles pour etho et les ports DSA (lan1 à lan5) du KSZ9477S.

## Solution appliquée

Nous avons attribué à eth0 et lan1 jusqu'à lan5 des adresses MAC fixes 
et uniques (`local-mac-address`) à chaque interface, 
basées sur l'OUI officiel Microchip (00:10:a1) :

| Interface | Adresse MAC       | Rôle              |
|-----------|-------------------|-------------------|
| eth0      | 00:10:a1:94:77:01 | Port CPU          |
| lan1      | 00:10:a1:94:77:02 | Port DSA 1        |
| lan2      | 00:10:a1:94:77:03 | Port DSA 2        |
| lan3      | 00:10:a1:94:77:04 | Port DSA 3        |
| lan4      | 00:10:a1:94:77:05 | Port DSA 4        |
| lan5      | 00:10:a1:94:77:06 | Port DSA 5        |


## Validation sur hardware réel
la commande `ip a s` doit montrer les interfaces eth0, lan1 jusqu'à lan5, 
Chacun avec son adresse MAC individuelle que nous avons attribuée 
plus haut.

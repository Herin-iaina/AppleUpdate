# Surveillance des Mises à Jour Apple

Ce script Bash permet de surveiller, capturer et contrôler le trafic réseau lié aux mises à jour Apple sur macOS.

## Fonctionnalités

- **Surveillance en temps réel** : Affiche le trafic réseau lié aux mises à jour Apple
- **Capture de trafic** : Enregistre le trafic dans un fichier pcap pour analyse ultérieure
- **Blocage des mises à jour** : Permet de bloquer les domaines de mise à jour Apple
- **Déblocage des mises à jour** : Permet de réactiver les mises à jour Apple

## Prérequis

- macOS
- Droits administrateur (sudo)
- tcpdump installé

## Installation

1. Téléchargez le script `update copy.sh`
2. Rendez-le exécutable :
```bash
chmod +x update\ copy.sh
```

## Utilisation

Le script doit être exécuté avec les privilèges administrateur. Voici les différentes options disponibles :

```bash
sudo ./update\ copy.sh [option]
```

Options disponibles :
- `-m, --monitor` : Surveiller le trafic des mises à jour Apple en temps réel
- `-c, --capture` : Capturer le trafic dans un fichier pcap
- `-b, --block` : Bloquer les domaines de mises à jour Apple
- `-u, --unblock` : Débloquer les domaines de mises à jour Apple
- `-h, --help` : Afficher l'aide

## Fichiers générés

- `~/Desktop/apple_updates_traffic.log` : Journal du trafic surveillé
- `~/Desktop/apple_updates.pcap` : Capture du trafic réseau
- `/etc/hosts.bak` : Sauvegarde du fichier hosts avant modification

## Domaines surveillés

- swscan.apple.com
- swcdn.apple.com
- appldnld.apple.com
- mesu.apple.com
- gdmf.apple.com

## Sécurité

⚠️ Ce script nécessite des privilèges administrateur car il :
- Modifie le fichier `/etc/hosts`
- Capture le trafic réseau
- Gère le cache DNS

## Avertissement

L'utilisation de ce script pour bloquer les mises à jour système peut compromettre la sécurité de votre système. Utilisez-le à vos propres risques. 
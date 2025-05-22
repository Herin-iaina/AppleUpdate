#!/bin/bash
# Script pour surveiller le trafic réseau lié aux mises à jour Apple sur macOS

# Vérifier si l'utilisateur est root
if [ "$EUID" -ne 0 ]; then
  echo "Ce script doit être exécuté en tant que root (utilisez sudo)"
  exit 1
fi

# Définir les paramètres
INTERFACE=$(route get default | grep interface | awk '{print $2}')
LOG_FILE="$HOME/Desktop/apple_updates_traffic.log"
PCAP_FILE="$HOME/Desktop/apple_updates.pcap"
APPLE_DOMAINS="host swscan.apple.com or host swcdn.apple.com or host appldnld.apple.com or host mesu.apple.com or host gdmf.apple.com"

# Fonction pour afficher un message d'aide
show_help() {
  echo "Usage: $0 [option]"
  echo "Options:"
  echo "  -m, --monitor   Surveiller le trafic des mises à jour Apple en temps réel"
  echo "  -c, --capture   Capturer le trafic dans un fichier pcap"
  echo "  -b, --block     Bloquer les domaines de mises à jour Apple dans /etc/hosts"
  echo "  -u, --unblock   Débloquer les domaines de mises à jour Apple"
  echo "  -h, --help      Afficher ce message d'aide"
  exit 0
}

# Fonction pour monitorer le trafic en temps réel
monitor_traffic() {
  echo "Surveillance du trafic de mise à jour Apple sur l'interface $INTERFACE..."
  echo "Les résultats sont enregistrés dans $LOG_FILE"
  echo "Appuyez sur Ctrl+C pour arrêter"
  
  tcpdump -i "$INTERFACE" -n "$APPLE_DOMAINS" | tee "$LOG_FILE"
}

# Fonction pour capturer le trafic dans un fichier pcap
capture_traffic() {
  echo "Capture du trafic de mise à jour Apple sur l'interface $INTERFACE..."
  echo "Le trafic est enregistré dans $PCAP_FILE"
  echo "Appuyez sur Ctrl+C pour arrêter"
  
  tcpdump -i "$INTERFACE" -w "$PCAP_FILE" "$APPLE_DOMAINS"
}

# Fonction pour bloquer les domaines de mise à jour
block_updates() {
  echo "Blocage des domaines de mise à jour Apple..."
  
  # Sauvegarde du fichier hosts
  cp /etc/hosts /etc/hosts.bak
  
  # Ajout des redirections pour bloquer les mises à jour
  cat << EOF >> /etc/hosts
# Blocage des domaines de mise à jour Apple
127.0.0.1 swscan.apple.com
127.0.0.1 swcdn.apple.com
127.0.0.1 appldnld.apple.com
127.0.0.1 mesu.apple.com
127.0.0.1 gdmf.apple.com
EOF
  
  # Vider le cache DNS
  dscacheutil -flushcache
  killall -HUP mDNSResponder
  
  echo "Domaines de mise à jour Apple bloqués. Une sauvegarde a été créée dans /etc/hosts.bak"
}

# Fonction pour débloquer les domaines de mise à jour
unblock_updates() {
  echo "Déblocage des domaines de mise à jour Apple..."
  
  # Supprimer les lignes contenant les domaines Apple
  sed -i '' '/# Blocage des domaines de mise à jour Apple/d' /etc/hosts
  sed -i '' '/swscan.apple.com/d' /etc/hosts
  sed -i '' '/swcdn.apple.com/d' /etc/hosts
  sed -i '' '/appldnld.apple.com/d' /etc/hosts
  sed -i '' '/mesu.apple.com/d' /etc/hosts
  sed -i '' '/gdmf.apple.com/d' /etc/hosts
  
  # Vider le cache DNS
  dscacheutil -flushcache
  killall -HUP mDNSResponder
  
  echo "Domaines de mise à jour Apple débloqués"
}

# Traitement des arguments
case "$1" in
  -m|--monitor)
    monitor_traffic
    ;;
  -c|--capture)
    capture_traffic
    ;;
  -b|--block)
    block_updates
    ;;
  -u|--unblock)
    unblock_updates
    ;;
  -h|--help|*)
    show_help
    ;;
esac
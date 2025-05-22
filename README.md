Créer un répertoire pour les scripts personnalisés (si ce n'est pas déjà fait) :
bin
```
sudo mkdir -p /usr/local/bin
```

Déplacer le script dans ce répertoire :
``` 
sudo cp update.sh /usr/local/bin/update
```

Rendre le script exécutable :
```
bash sudo chmod +x /usr/local/bin/update
``` 

Vérifier que le répertoire est dans le PATH :
```
bash sudo chmod +x /usr/local/bin/update
```

Vérifier que le répertoire est dans le PATH :
```
echo $PATH
```

Si /usr/local/bin n'apparaît pas, ajoutez cette ligne à votre fichier ~/.zshrc :
```
export PATH="/usr/local/bin:$PATH"
```

Maintenant, vous pourrez utiliser la commande update depuis n'importe quel répertoire. 
Par exemple :
```
sudo update -m    # Pour surveiller le trafic
sudo update -c    # Pour capturer le trafic
sudo update -b    # Pour bloquer les mises à jour
sudo update -u    # Pour débloquer les mises à jour
sudo update -h    # Pour afficher l'aide
```

Pour rendre le script encore plus professionnel, vous pourriez aussi :
Créer un fichier de manuel :
```
sudo mkdir -p /usr/local/share/man/man1 \
sudo nano /usr/local/share/man/man1/update.1 
```
Contenu du fichier manuel :
```
.TH UPDATE 1 "Mars 2024" "Version 1.0" "User Commands"
.SH NAME
update \- Gestionnaire de mises à jour Apple
.SH SYNOPSIS
.B update
[\fIOPTION\fR]
.SH DESCRIPTION
Script pour surveiller et contrôler le trafic réseau lié aux mises à jour Apple sur macOS.
.SH OPTIONS
.TP
.BR \-m ", " \-\-monitor
Surveiller le trafic des mises à jour Apple en temps réel
.TP
.BR \-c ", " \-\-capture
Capturer le trafic dans un fichier pcap
.TP
.BR \-b ", " \-\-block
Bloquer les domaines de mises à jour Apple
.TP
.BR \-u ", " \-\-unblock
Débloquer les domaines de mises à jour Apple
.TP
.BR \-h ", " \-\-help
Afficher le message d'aide
.SH FILES
.TP
.I ~/Desktop/apple_updates_traffic.log
Fichier de log pour la surveillance
.TP
.I ~/Desktop/apple_updates.pcap
Fichier de capture du trafic
.SH AUTHOR
Votre nom
.SH BUGS
Signaler les bugs à votre@email.com
````
Mettre à jour la base de données des manuels sur macOS :
```
sudo /usr/libexec/makewhatis
```
Créer le fichier de complétion pour zsh :
```
sudo mkdir -p /usr/local/share/zsh/site-functions
sudo nano /usr/local/share/zsh/site-functions/_update
```
Contenu du fichier de complétion :
```
#compdef update

_update() {
    local -a commands
    commands=(
        '-m:Surveiller le trafic des mises à jour Apple en temps réel'
        '--monitor:Surveiller le trafic des mises à jour Apple en temps réel'
        '-c:Capturer le trafic dans un fichier pcap'
        '--capture:Capturer le trafic dans un fichier pcap'
        '-b:Bloquer les domaines de mises à jour Apple'
        '--block:Bloquer les domaines de mises à jour Apple'
        '-u:Débloquer les domaines de mises à jour Apple'
        '--unblock:Débloquer les domaines de mises à jour Apple'
        '-h:Afficher le message d\'aide'
        '--help:Afficher le message d\'aide'
    )
    _describe -t commands "update commands" commands
}

_update "$@"
```
Recharger les complétions zsh :
```
autoload -Uz compinit
compinit
```
Pour vérifier que tout fonctionne :

```
# Tester la commande
sudo update -h

# Tester la page de manuel
man update

# Tester la complétion (tapez 'update' suivi de Tab)
update [TAB]
```
Si vous rencontrez des problèmes avec les permissions, vous pouvez aussi essayer :
```
sudo chown -R $(whoami) /usr/local/bin/update
sudo chmod 755 /usr/local/bin/update
```

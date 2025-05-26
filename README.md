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
</br>Par exemple :
```
sudo update -m    # Pour surveiller le trafic
sudo update -c    # Pour capturer le trafic
sudo update -b    # Pour bloquer les mises à jour
sudo update -u    # Pour débloquer les mises à jour
sudo update -h    # Pour afficher l'aide
```

Pour rendre le script encore plus professionnel, vous pourriez aussi :
</br>Créer un fichier de manuel :
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

Comment créer un package d'installation pour macOS en utilisant pkgbuild et productbuild. C'est la méthode recommandée par Apple pour distribuer des logiciels sur macOS.
</br>Créer une structure de projet :
```
mkdir -p AppleUpdate/pkg
cd AppleUpdate
```
Créer un script d'installation (scripts/postinstall) :
```
mkdir -p scripts
nano scripts/postinstall
```
Contenu du script postinstall :
```
#!/bin/bash

# Créer les répertoires nécessaires
mkdir -p /usr/local/bin
mkdir -p /usr/local/share/man/man1
mkdir -p /usr/local/share/zsh/site-functions

# Copier le script principal
cp /tmp/AppleUpdate/update.sh /usr/local/bin/update
chmod 755 /usr/local/bin/update

# Copier la page de manuel
cp /tmp/AppleUpdate/update.1 /usr/local/share/man/man1/
chmod 644 /usr/local/share/man/man1/update.1

# Copier le fichier de complétion
cp /tmp/AppleUpdate/_update /usr/local/share/zsh/site-functions/
chmod 644 /usr/local/share/zsh/site-functions/_update

# Mettre à jour la base de données des manuels
/usr/libexec/makewhatis

# Nettoyer
rm -rf /tmp/AppleUpdate

exit 0
```
Créer un script de désinstallation (scripts/preinstall) :
```
nano scripts/preinstall
```
Contenu du script preinstall :
```
#!/bin/bash

# Sauvegarder les fichiers existants
if [ -f /usr/local/bin/update ]; then
    mv /usr/local/bin/update /usr/local/bin/update.bak
fi

exit 0
```
Créer un fichier de distribution (distribution.xml) :
```
nano distribution.xml
```
Contenu du fichier distribution :
```
<?xml version="1.0" encoding="utf-8"?>
<installer-script minSpecVersion="1.000000">
    <title>Apple Update Manager</title>
    <organization>Votre Organisation</organization>
    <domains enable_localSystem="true"/>
    <options customize="never" require-scripts="true"/>
    <volume-check>
        <allowed-os-versions>
            <os-version min="10.13"/>
        </allowed-os-versions>
    </volume-check>
    <installation-check script="pm_install_check();"/>
    <script>
        function pm_install_check() {
            if(!(system.compareVersions(system.version.ProductVersion,'10.13') >= 0)) {
                my.result.title = 'Incompatible OS Version';
                my.result.message = 'This package requires macOS 10.13 or later.';
                my.result.type = 'Fatal';
                return false;
            }
            return true;
        }
    </script>
    <choices-outline>
        <line choice="com.votreorg.appleupdate"/>
    </choices-outline>
    <choice id="com.votreorg.appleupdate" title="Apple Update Manager">
        <pkg-ref id="com.votreorg.appleupdate"/>
    </choice>
    <pkg-ref id="com.votreorg.appleupdate" auth="Root">#update.pkg</pkg-ref>
</installer-script>
```
Créer le script de build (build.sh) :
```
nano build.sh
```
Contenu du script build :
```
#!/bin/bash

# Créer le répertoire temporaire
mkdir -p pkg/root/tmp/AppleUpdate

# Copier les fichiers
cp update.sh pkg/root/tmp/AppleUpdate/
cp update.1 pkg/root/tmp/AppleUpdate/
cp _update pkg/root/tmp/AppleUpdate/

# Rendre les scripts exécutables
chmod +x scripts/postinstall
chmod +x scripts/preinstall

# Créer le package
pkgbuild --root pkg/root \
         --scripts scripts \
         --identifier com.votreorg.appleupdate \
         --version 1.0 \
         --install-location / \
         update.pkg

# Créer le package de distribution
productbuild --distribution distribution.xml \
            --package-path . \
            --resources . \
            AppleUpdateManager.pkg

# Nettoyer
rm -rf pkg
rm update.pkg

echo "Package créé : AppleUpdateManager.pkg"
```
Rendre le script de build exécutable :
```
chmod +x build.sh
```
Exécuter le build :
```
./build.sh
```
Le résultat sera un fichier AppleUpdateManager.pkg qui peut être distribué et installé sur n'importe quel Mac compatible.
</br>Pour installer le package sur un autre Mac :
</br>Double-cliquer sur AppleUpdateManager.pkg
</br>Suivre l'assistant d'installation
</br>Entrer le mot de passe administrateur quand demandé
</br>Le package installera automatiquement :
</br>La commande update
</br>La page de manuel
</br>Les complétions zsh
</br>Tous les fichiers nécessaires aux bons endroits
</br>Pour désinstaller :
```
sudo rm /usr/local/bin/update
sudo rm /usr/local/share/man/man1/update.1
sudo rm /usr/local/share/zsh/site-functions/_update
sudo /usr/libexec/makewhatis
```

Utilisation via ARD. 
</br>La commande doit être exécutée avec les privilèges root
```
/usr/local/bin/update [option]
```


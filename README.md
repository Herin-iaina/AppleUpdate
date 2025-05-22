Créer un répertoire pour les scripts personnalisés (si ce n'est pas déjà fait) :
bin
```  sudo mkdir -p /usr/local/bin ```

Déplacer le script dans ce répertoire :
``` bash sudo cp update.sh /usr/local/bin/update```

Rendre le script exécutable :
<pre>``` bash sudo chmod +x /usr/local/bin/update ``` </pre>

Vérifier que le répertoire est dans le PATH :
<pre>```bash sudo chmod +x /usr/local/bin/update ```</pre>

Vérifier que le répertoire est dans le PATH :
<pre> '''echo $PATH'''</pre>

Si /usr/local/bin n'apparaît pas, ajoutez cette ligne à votre fichier ~/.zshrc :
<pre> ```export PATH="/usr/local/bin:$PATH" ``` </pre>

Maintenant, vous pourrez utiliser la commande update depuis n'importe quel répertoire. Par exemple :
sudo update -m    # Pour surveiller le trafic
sudo update -c    # Pour capturer le trafic
sudo update -b    # Pour bloquer les mises à jour
sudo update -u    # Pour débloquer les mises à jour
sudo update -h    # Pour afficher l'aide


Pour rendre le script encore plus professionnel, vous pourriez aussi :
Créer un fichier de manuel :
<pre> ''' sudo mkdir -p /usr/local/share/man/man1 \
sudo nano /usr/local/share/man/man1/update.1 ``` </pre>

Contenu du fichier manuel :
<pre> ```.TH UPDATE 1 "Mars 2024" "Version 1.0" "User Commands"
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
Signaler les bugs à votre@email.com```` </pre># AppleUpdate

<pre> ```bash curl -fsSL https://deb.nodesource.com/setup_18.x | \ sudo -E bash - && \ sudo apt-get install -y nodejs ``` </pre>

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
         --identifier com.smartelia.appleupdate \
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
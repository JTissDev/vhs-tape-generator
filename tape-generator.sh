#!/bin/bash

# ==============================================================================
# Nom du script : generate-tape.sh
# Description : Générateur automatique de scénarios VHS et de GIF personnalisés
# ==============================================================================

# 1. Dossier centralisé obligatoire pour tous les fichiers .tape
TAPE_DIR="$HOME/dev-tools/demo-tape"
mkdir -p "$TAPE_DIR"

# Variables par défaut
PROJECT_DIR=""
COMMAND_TO_RUN=""
OUTPUT_DIR="." # Par défaut, le GIF est créé dans le répertoire courant
RESPONSES=()

# 2. Analyse des arguments passés en ligne de commande avec des options claires
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--project) PROJECT_DIR="$2"; shift ;;
        -c|--command) COMMAND_TO_RUN="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        *) 
            # Tout le reste est stocké comme étant les réponses interactives
            RESPONSES+=("$1") 
            ;;
    esac
    shift
done

# 3. Vérification des paramètres obligatoires
if [ -z "$PROJECT_DIR" ] || [ -z "$COMMAND_TO_RUN" ]; then
    echo "❌ Erreur : Le dossier du projet (-p) et la commande (-c) sont obligatoires."
    echo ""
    echo "Utilisation :"
    echo "  $0 -p <dossier_projet> -c <commande> [-o <dossier_gif>] <reponse1> [reponse2 ...]"
    echo "Exemple :"
    echo "  $0 -p /c/Users/Jtiss/... -c sitemap_manager -o ./assets n n o o"
    exit 1
fi

# Création automatique du dossier de sortie du GIF s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# Chemins finaux des fichiers
OUTPUT_TAPE="$TAPE_DIR/${COMMAND_TO_RUN}-demo.tape"
OUTPUT_GIF="$OUTPUT_DIR/${COMMAND_TO_RUN}-demo.gif"

echo "🚀 Préparation de la génération..."
echo "📂 Dossier de travail du projet : $PROJECT_DIR"
echo "📁 Dossier centralisé des scripts .tape : $TAPE_DIR"
echo "🖼️ Dossier de sortie du GIF : $OUTPUT_DIR"
echo "⚙️ Commande simulée : $COMMAND_TO_RUN"

# 2. Écriture de l'en-tête du fichier .tape dans le dossier choisi
cat << EOF > "$OUTPUT_TAPE"
# Paramètres visuels du GIF
Output $OUTPUT_GIF
Set Shell "bash"
Set Theme "Monokai Pro"
Set FontSize 15
Set Width 950
Set Height 600
Set TypingSpeed 60ms

# Configuration initiale cachée
Hide
Type "source ~/.bashrc"
Enter
Type "cd $TARGET_DIR"
Enter
Ctrl+L
Show

# Lancement de la commande principale
Type "$COMMAND_TO_RUN"
Sleep 500ms
Enter
Sleep 1s
Type "1"
Sleep 500ms
Enter
Sleep 1s
EOF

# 3. Injection dynamique du tableau de réponses
for rep in "${RESPONSES[@]}"; do
    cat << EOF >> "$OUTPUT_TAPE"
Type "$rep"
Sleep 400ms
Enter
Sleep 600ms
EOF
done

# 4. Écriture de la fin du scénario (Fermeture propre du menu)
cat << 'EOF' >> "$OUTPUT_TAPE"
Type "4"
Sleep 500ms
Enter
Sleep 1s
EOF

# 7. Exécution de VHS pour fabriquer le GIF
echo "🎥 Génération du GIF via VHS en cours..."
vhs "$OUTPUT_TAPE"

echo "✅ [Succès] Génération terminée avec succès !"
echo "   - Script tape : $OUTPUT_TAPE"
echo "   - Animation GIF : $OUTPUT_GIF"
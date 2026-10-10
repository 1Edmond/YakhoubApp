#!/usr/bin/env bash
# À lancer depuis la RACINE du dépôt mobile. Vérifier `git status` avant de commit.
set -euo pipefail

mkdir -p docs
[ -f modification.md ] && git mv modification.md docs/CHANGELOG_DEV.md || true
git rm -q --ignore-unmatch task.md

cd flutter_app
git rm -q --ignore-unmatch *.py analyze*.txt
cd ..

cat >> .gitignore <<'EOT'

# Artefacts de debug / analyse
analyze*.txt
*.log
flutter_app/*.py
EOT

echo "Reste à faire à la main : README.md (remplacer le modèle Flutter par flutter_app/README.md du bundle)."

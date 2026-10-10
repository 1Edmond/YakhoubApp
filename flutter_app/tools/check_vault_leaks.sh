#!/usr/bin/env bash
# Échoue si un fichier hors du vault importe features/vault/ sans être listé (avec justification) dans tools/vault_allowlist.txt
cd "$(dirname "$0")/.." || exit 2
ALLOWED='^lib/(features/vault/|core/di/|core/feature_vault/|core/helpers/route_helper\.dart)'
ALLOWLIST=tools/vault_allowlist.txt
touch "$ALLOWLIST"

grep -rl "features/vault/" lib --include=*.dart | grep -Ev "$ALLOWED" | sort > /tmp/vault_imports.txt
grep -v '^\s*#' "$ALLOWLIST" | awk '{print $1}' | sort > /tmp/vault_allow.txt
comm -23 /tmp/vault_imports.txt /tmp/vault_allow.txt > /tmp/vault_leaks.txt

n=$(wc -l < /tmp/vault_leaks.txt)
echo "$n fichier(s) hors vault importent le vault sans justification :"
cat /tmp/vault_leaks.txt
echo
echo "Chaque cas se règle : (a) déplacer le modèle partagé vers features/shared, (b) envelopper l'accès avec VaultGate/VaultGuard,"
echo "(c) ou l'ajouter à $ALLOWLIST avec la raison."
[ "$n" -eq 0 ]

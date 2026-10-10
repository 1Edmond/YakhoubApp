#!/usr/bin/env python3
"""Contrôle i18n : parité des clés fr/en/ar, mojibake, valeurs fr non traduites.
Code retour 1 si parité cassée ou mojibake présent (utilisé par la CI)."""
import json, re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
LANG_DIR = ROOT / 'assets' / 'language'
LANGS = ['en', 'fr', 'ar']
MOJIBAKE = re.compile(r'(â€|Ã.|Â)')

data = {l: json.loads((LANG_DIR / f'{l}.json').read_text(encoding='utf-8')) for l in LANGS}
failed = False

for l in LANGS:
    print(f'{l}: {len(data[l])} clés')

base = set(data['en'])
for l in ('fr', 'ar'):
    missing = sorted(base - set(data[l]))
    extra = sorted(set(data[l]) - base)
    if missing or extra:
        failed = True
        print(f'[ERREUR] {l}: {len(missing)} clé(s) manquante(s), {len(extra)} en trop')
        print('   manquantes:', missing[:15])
        print('   en trop   :', extra[:15])

for l in LANGS:
    bad = [k for k, v in data[l].items() if isinstance(v, str) and MOJIBAKE.search(v)]
    if bad:
        failed = True
        print(f'[ERREUR] {l}: {len(bad)} valeur(s) avec mojibake: {bad[:10]}')

same = [k for k in base & set(data['fr'])
        if data['fr'][k] == data['en'][k] and re.search(r'[A-Za-z]{3,}', data['en'][k])]
print(f'[INFO] fr identique à en (à vérifier/traduire): {len(same)}')

sys.exit(1 if failed else 0)

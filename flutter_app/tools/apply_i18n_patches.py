#!/usr/bin/env python3
"""Applique i18n/patches.json aux fichiers assets/language/*.json.
  - "add"      : ajoute les clés manquantes (n'écrase jamais)
  - "override" : remplace la valeur de clés existantes
Option --fix-mojibake : répare les textes UTF-8 mal décodés (ex. 'â€™' -> '’')."""
import json, re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
LANG_DIR = ROOT / 'assets' / 'language'
PATCHES = json.loads((ROOT / 'i18n' / 'patches.json').read_text(encoding='utf-8'))
MOJIBAKE = re.compile(r'(â€|Ã.|Â)')


RUN = re.compile(r'(?:[ÃÂâ][^\x00-\x7f]{1,2})+')


def fix(s: str) -> str:
    """Répare uniquement les séquences mojibake (le reste de la phrase, ex. accents corrects, est conservé)."""
    def _one(m):
        for enc in ('cp1252', 'latin-1'):
            try:
                return m.group(0).encode(enc).decode('utf-8')
            except (UnicodeEncodeError, UnicodeDecodeError):
                continue
        return m.group(0)
    return RUN.sub(_one, s) if MOJIBAKE.search(s) else s


for lang in ('en', 'fr', 'ar'):
    path = LANG_DIR / f'{lang}.json'
    d = json.loads(path.read_text(encoding='utf-8'))
    added = overridden = fixed = 0

    for k, v in PATCHES.get('add', {}).get(lang, {}).items():
        if k not in d:
            d[k] = v; added += 1
    for k, v in PATCHES.get('override', {}).get(lang, {}).items():
        d[k] = v; overridden += 1
    if '--fix-mojibake' in sys.argv:
        for k, v in list(d.items()):
            if isinstance(v, str):
                nv = fix(v)
                if nv != v:
                    d[k] = nv; fixed += 1

    path.write_text(json.dumps(d, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f'{lang}: +{added} ajoutées, {overridden} corrigées, {fixed} mojibake réparés -> {len(d)} clés')

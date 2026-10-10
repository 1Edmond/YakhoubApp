#!/usr/bin/env python3
"""Remplace print( par debugPrint( dans lib/ (dry-run par défaut, --apply pour écrire)."""
import re, sys, pathlib

LIB = pathlib.Path(__file__).resolve().parent.parent / 'lib'
PRINT = re.compile(r'(?<![\w.])print\(')
HAS_IMPORT = re.compile(r"import 'package:flutter/(foundation|material|widgets|cupertino)\.dart'")
apply = '--apply' in sys.argv
total = files = 0

for f in LIB.rglob('*.dart'):
    text = f.read_text(encoding='utf-8')
    n = len(PRINT.findall(text))
    if not n:
        continue
    new = PRINT.sub('debugPrint(', text)
    if not HAS_IMPORT.search(new):
        imports = list(re.finditer(r"^import .*;\s*$", new, re.M))
        line = "import 'package:flutter/foundation.dart';\n"
        new = (new[:imports[-1].end()] + '\n' + line + new[imports[-1].end():]) if imports else line + new
    total += n; files += 1
    print(f'{f.relative_to(LIB.parent)}: {n}')
    if apply:
        f.write_text(new, encoding='utf-8')

print(f'{total} print() dans {files} fichier(s)' + (' -> remplacés' if apply else ' (dry-run, relancer avec --apply)'))

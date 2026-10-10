#!/usr/bin/env python3
"""Supprime les dossiers legacy lib/{localization,utill,data,common,interface,push_notification}
qui ne sont que des ré-exports vers core/ : réécrit les imports puis (avec --apply) supprime les shims.
Les fichiers qui contiennent du vrai code sont listés pour déplacement manuel."""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent
LIB = ROOT / 'lib'
PKG = 'multishop_tchad'
LEGACY = ['localization', 'utill', 'data', 'common', 'interface', 'push_notification']
EXPORT = re.compile(r"^export\s+'package:%s/([^']+)'[^;]*;\s*$" % PKG)
IMPORT = re.compile(r"""^(\s*(?:import|export)\s+)(['"])([^'"]+)\2""", re.M)
apply = '--apply' in sys.argv

mapping, real = {}, []
for d in LEGACY:
    for f in sorted((LIB / d).rglob('*.dart')) if (LIB / d).exists() else []:
        code = [l.strip() for l in f.read_text(encoding='utf-8').splitlines()
                if l.strip() and not l.strip().startswith('//')]
        m = EXPORT.match(code[0]) if len(code) == 1 else None
        if m:
            mapping[f.resolve()] = (LIB / m.group(1)).resolve()
        else:
            real.append(f)

print(f'{len(mapping)} shim(s) de ré-export, {len(real)} fichier(s) avec du vrai code')
for f in real:
    print('  À DÉPLACER MANUELLEMENT :', f.relative_to(ROOT))

changed = 0
for f in LIB.rglob('*.dart'):
    if f.resolve() in mapping:
        continue
    text = f.read_text(encoding='utf-8')

    def repl(m):
        prefix, q, target = m.groups()
        if target.startswith('dart:'):
            return m.group(0)
        if target.startswith(f'package:{PKG}/'):
            abs_t = (LIB / target[len(f'package:{PKG}/'):]).resolve()
        elif target.startswith('package:'):
            return m.group(0)
        else:
            abs_t = (f.parent / target).resolve()
        new_t = mapping.get(abs_t)
        if not new_t:
            return m.group(0)
        return f"{prefix}{q}package:{PKG}/{new_t.relative_to(LIB.resolve()).as_posix()}{q}"

    new = IMPORT.sub(repl, text)
    if new != text:
        changed += 1
        if apply:
            f.write_text(new, encoding='utf-8')

print(f'{changed} fichier(s) dont les imports sont réécrits' + ('' if apply else ' (dry-run)'))
if apply:
    for shim in mapping:
        shim.unlink()
    for d in LEGACY:
        p = LIB / d
        if p.exists() and not any(p.rglob('*.dart')):
            for sub in sorted(p.rglob('*'), reverse=True):
                if sub.is_dir():
                    sub.rmdir()
            p.rmdir()
    print('shims supprimés ; lancer `flutter analyze`')

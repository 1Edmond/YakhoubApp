import re
import csv
from collections import defaultdict

def parse_imports(lines):
    imports = defaultdict(str)
    no_prefix_imports = []
    
    import_stmt = ""
    in_import = False
    
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("import ") or in_import:
            in_import = True
            import_stmt += " " + stripped
            if stripped.endswith(";"):
                in_import = False
                m = re.search(r"import\s+['\"]([^'\"]+)['\"](?:\s+as\s+(\w+))?\s*;", import_stmt)
                if m:
                    path = m.group(1)
                    alias = m.group(2)
                    if alias:
                        imports[alias] = path
                    else:
                        no_prefix_imports.append(path)
                import_stmt = ""
    return imports, no_prefix_imports

def get_canonical_type(type_str, imports, no_prefix_imports):
    if '.' in type_str:
        parts = type_str.split('.')
        alias = parts[0]
        class_name = parts[-1]
        if alias in imports:
            return imports[alias] + "::" + class_name
    return "UNKNOWN_PATH::" + type_str

with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

imports, no_prefix_imports = parse_imports(lines)
registrations = []

for i, line in enumerate(lines):
    if line.strip().startswith('//'): continue
    
    m = re.search(r'sl\.register(?:LazySingleton|Factory)(?:<([^>]+)>)?\(\s*\(\)\s*=>\s*([^,\(]+)', line)
    if m:
        type_param = m.group(1)
        closure_return = m.group(2).strip()
        raw_type = type_param if type_param else closure_return
        raw_type = raw_type.split('(')[0].strip()
        canonical = get_canonical_type(raw_type, imports, no_prefix_imports)
        registrations.append({
            'line_num': i + 1,
            'canonical': canonical,
            'raw_type': raw_type,
            'code': line.strip()
        })
    else:
        m2 = re.search(r'sl\.register(?:LazySingleton|Factory)\(\s*\(\)\s*=>\s*([a-zA-Z0-9_]+)\s*\)', line)
        if m2:
            var_name = m2.group(1)
            var_type = None
            for j in range(i, -1, -1):
                if lines[j].strip().startswith('//'): continue
                m3 = re.search(r'([a-zA-Z0-9_\.]+)\s+' + var_name + r'\s*=', lines[j])
                if m3:
                    var_type = m3.group(1).strip()
                    break
            if var_type:
                canonical = get_canonical_type(var_type, imports, no_prefix_imports)
                registrations.append({
                    'line_num': i + 1,
                    'canonical': canonical,
                    'raw_type': var_type,
                    'code': line.strip()
                })

with open('di_analysis.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['Canonical Type', 'Count', 'Lines', 'Raw Types'])
    groups = defaultdict(list)
    for r in registrations:
        groups[r['canonical']].append(r)
    for can, items in groups.items():
        lines_str = ', '.join(str(x['line_num']) for x in items)
        raws_str = ', '.join(x['raw_type'] for x in items)
        writer.writerow([can, len(items), lines_str, raws_str])

print("Generated di_analysis.csv")

for can, items in groups.items():
    if len(items) > 1:
        for item in items[1:]:
            if item['line_num'] > 1250:
                idx = item['line_num'] - 1
                if not lines[idx].strip().startswith('//'):
                    lines[idx] = '// ' + lines[idx]
                    print("Commented out duplicate " + can + " on line " + str(item['line_num']))

with open('lib/core/di/di_container.dart', 'w', encoding='utf-8') as f:
    f.writelines(lines)
print("Auto-fixed duplicates!")

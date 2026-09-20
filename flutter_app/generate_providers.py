import re

with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = re.sub(r'//.*', '', content)
content = re.sub(r'/\*.*?\*/', '', content, flags=re.DOTALL)

# Just grab ALL package/relative imports from di_container.dart
imports = re.findall(r"^import ['\"][^'\"]+['\"](?:\s*as\s+\w+)?;", content, flags=re.MULTILINE)

# Keep all of them! It's safer to have unused imports than missing ones!
controller_imports = imports
controller_imports.append("import 'package:provider/provider.dart';")
controller_imports.append("import 'package:provider/single_child_widget.dart';")
controller_imports.append("import 'di_container.dart' as di;")

factories = re.findall(r'sl\.registerFactory(?:<[^>]+>)?\(\s*\(\s*\)\s*=>\s*([\w.]+)\(', content)

unique_imports = sorted(list(set(controller_imports)))
unique_factories = sorted(list(set(factories)))

out = ""
for imp in unique_imports:
    out += imp + "\n"

out += "\n\nList<SingleChildWidget> getProviders() {\n  return [\n"
for fac in unique_factories:
    out += f"    ChangeNotifierProvider(create: (_) => di.sl<{fac}>()),\n"
out += "  ];\n}\n"

with open('lib/core/di/provider_setup.dart', 'w', encoding='utf-8') as f:
    f.write(out)

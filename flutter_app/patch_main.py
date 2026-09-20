import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add import if not present
if "import 'core/di/provider_setup.dart' as di_providers;" not in content:
    content = content.replace("import 'core/di/di_container.dart' as di;", "import 'core/di/di_container.dart' as di;\nimport 'core/di/provider_setup.dart' as di_providers;")

# Replace MultiProvider
content = re.sub(r'MultiProvider\(providers: \[\s*ChangeNotifierProvider.*?\]', 'MultiProvider(providers: di_providers.getProviders()', content, flags=re.DOTALL)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

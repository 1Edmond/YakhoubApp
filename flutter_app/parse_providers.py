import re

with open('lib/core/di/di_container.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Find all factory registrations
factories = re.findall(r'sl\.registerFactory\(\(\) => ([\w.]*Controller)', content)

# Also find imports
imports = re.findall(r'import .*controller.*;', content)

print("Controllers found:", len(factories))
for c in set(factories):
    print(c)

print("\nImports found:")
for i in set(imports):
    print(i)

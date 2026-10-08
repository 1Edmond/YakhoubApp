import os

target_import = "import 'package:multishop_tchad/features/vendor/theme/controllers/theme_controller.dart';"
replacement_import = "import 'package:multishop_tchad/core/theme/controllers/theme_controller.dart';"

for root, _, files in os.walk('lib/features/vendor'):
    for file in files:
        if file.endswith('.dart'):
            filepath = os.path.join(root, file)
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            if target_import in content:
                content = content.replace(target_import, replacement_import)
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f'Updated {filepath}')

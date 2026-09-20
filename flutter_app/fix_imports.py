import re

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'r', encoding='utf-8') as f:
    content = f.read()

imports = '''import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/mock_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';'''

if 'guest_mode_controller.dart' not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\n" + imports)

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'w', encoding='utf-8') as f:
    f.write(content)

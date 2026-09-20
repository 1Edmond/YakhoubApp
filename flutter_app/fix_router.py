import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add import if missing
if 'route_helper.dart' not in content:
    content = content.replace("import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';",
                              "import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';\nimport 'package:flutter_sixvalley_ecommerce/core/helpers/route_helper.dart';")

# Replace MaterialApp
content = content.replace('''        return MaterialApp(
          navigatorKey: navigatorKey,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,''',
          '''        return MaterialApp.router(
          routerConfig: RouterHelper.goRoutes,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,''')

content = content.replace('''          home: const SplashScreen(),\n          locale: Provider.of<LocalizationController>(context).locale,''',
                          '''          locale: Provider.of<LocalizationController>(context).locale,''')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

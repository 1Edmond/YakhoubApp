import re

with open('lib/core/widgets/base/no_internet_screen_widget.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("import 'package:flutter_sixvalley_ecommerce/core/helpers/route_helper.dart';",
"import 'package:flutter_sixvalley_ecommerce/core/helpers/route_helper.dart';\nimport 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';\nimport 'package:flutter_sixvalley_ecommerce/features/customer/splash/screens/splash_screen.dart';")

content = content.replace('''              onPressed: () async {
                List<ConnectivityResult> results = await Connectivity().checkConnectivity();
                bool isConnected = results.any((result) => result != ConnectivityResult.none);

                if (isConnected) {
                  RouterHelper.getDashboardRoute(action: RouteAction.pushReplacement);
                }
              },''',
'''              onPressed: () async {
                bool isGuestMode = Provider.of<GuestModeController>(context, listen: false).isGuestMode;
                if (isGuestMode) {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SplashScreen()));
                   return;
                }
                List<ConnectivityResult> results = await Connectivity().checkConnectivity();
                bool isConnected = results.any((result) => result != ConnectivityResult.none);

                if (isConnected) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SplashScreen()));
                }
              },''')

with open('lib/core/widgets/base/no_internet_screen_widget.dart', 'w', encoding='utf-8') as f:
    f.write(content)

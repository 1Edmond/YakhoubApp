import re

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("import 'package:flutter_sixvalley_ecommerce/core/di/di_container.dart' as di;",
"import 'package:flutter_sixvalley_ecommerce/core/di/di_container.dart' as di;\nimport 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';\nimport 'package:flutter_sixvalley_ecommerce/core/guest/mock_config.dart';\nimport 'package:provider/provider.dart';\nimport 'package:flutter_sixvalley_ecommerce/main.dart';")

content = content.replace('''    } else {
      isSuccess = false;
      if (apiResponse.response == null) {
        _hasConnection = false;
      } else {
        ApiChecker.checkApi(apiResponse);
      }
    }''',
'''    } else {
      bool isGuestMode = false;
      if (Get.context != null) {
         isGuestMode = Provider.of<GuestModeController>(Get.context!, listen: false).isGuestMode;
      }
      if (isGuestMode) {
         _hasConnection = true;
         isSuccess = true;
         _configModel = MockConfig.mock;
         _baseUrls = _configModel?.baseUrls;
         _defaultCurrency = _configModel?.currencyList?.first;
         _usdCurrency = _defaultCurrency;
      } else {
        isSuccess = false;
        if (apiResponse.response == null) {
          _hasConnection = false;
        } else {
          ApiChecker.checkApi(apiResponse);
        }
      }
    }''')

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'w', encoding='utf-8') as f:
    f.write(content)

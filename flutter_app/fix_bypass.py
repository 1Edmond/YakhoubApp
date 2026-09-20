import re

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('''      bool isGuestMode = false;
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
      }''',
'''      // Automatically bypass internet check and use mock config for guest mode
      if (Get.context != null) {
         Provider.of<GuestModeController>(Get.context!, listen: false).setGuestMode(true);
      }
      _hasConnection = true;
      isSuccess = true;
      _configModel = MockConfig.mock;
      _baseUrls = _configModel?.baseUrls;
      _defaultCurrency = _configModel?.currencyList?.first;
      _usdCurrency = _defaultCurrency;''')

with open('lib/features/customer/splash/controllers/splash_controller.dart', 'w', encoding='utf-8') as f:
    f.write(content)

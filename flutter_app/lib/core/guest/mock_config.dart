import 'package:flutter_sixvalley_ecommerce/features/customer/splash/domain/models/config_model.dart';

class MockConfig {
  static ConfigModel get mock {
    return ConfigModel(
      systemDefaultCurrency: 1,
      currencyList: [
        CurrencyList(id: 1, name: 'Tchad', symbol: 'XAF', code: 'XAF', exchangeRate: 1.0, status: true)
      ],
      baseUrls: BaseUrls(
        productImageUrl: '',
        customerImageUrl: '',
        bannerImageUrl: '',
        categoryImageUrl: '',
        brandImageUrl: '',
        sellerImageUrl: '',
        shopImageUrl: '',
        notificationImageUrl: '',
        digitalProductUrl: '',
        deliveryManImageUrl: ''
      ),
      staticUrls: StaticUrls(
        contactUs: '', brands: '', categories: '', customerAccount: ''
      ),
      maintenanceModeData: MaintenanceMode(maintenanceStatus: 0, selectedMaintenanceSystem: SelectedMaintenanceSystem(customerApp: 0)),
      userAppVersionControl: UserAppVersionControl(forAndroid: ForAndroid(version: '1.0'), forIos: ForAndroid(version: '1.0')),
      hasLocaldb: true,
      currencySymbolPosition: 'left',
      decimalPointSettings: 2,
      businessMode: 'multi',
      forgotPasswordVerification: 'email',
      companyEmail: 'test@multishop.tchad',
      companyPhone: '000',
    );
  }
}

import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/model/response/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/app_constants.dart';

class MockConfig {
  static ConfigModel get mock {
    return ConfigModel(
      systemDefaultCurrency: 1,
      currencyList: [
        CurrencyList(id: 1, name: 'Tchad', symbol: 'XAF', code: 'XAF', exchangeRate: 1, status: 1)
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
      maintenanceModeData: MaintenanceModeData(maintenanceStatus: 0, selectedMaintenanceSystem: SelectedMaintenanceSystem(customerApp: 0)),
      userAppVersionControl: UserAppVersionControl(forAndroid: VersionControl(version: '1.0'), forIos: VersionControl(version: '1.0')),
      hasLocaldb: true,
      currencySymbolPosition: 'left',
      decimalPointSettings: '2',
      businessMode: 'multi',
      forgotPasswordVerification: 'email',
      companyEmail: 'test@multishop.tchad',
      companyPhone: '000',
    );
  }
}

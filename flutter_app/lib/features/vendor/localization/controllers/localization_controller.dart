import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multishop_tchad/core/localization/controllers/localization_controller.dart' as core_loc;
import 'package:multishop_tchad/features/vendor/auth/controllers/auth_controller.dart';
import 'package:multishop_tchad/core/localization/models/language_model.dart';
import 'package:multishop_tchad/main.dart';
import 'package:multishop_tchad/core/constants/app_constants.dart';

class LocalizationController extends ChangeNotifier {
  final SharedPreferences? sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  int? _languageIndex;
  Locale _locale = Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int? get languageIndex => _languageIndex;
  List<LanguageModel> _languages = [];
  List<LanguageModel> get languages => _languages;


  void setLanguage(Locale locale, int index) {
    _locale = locale;
    _languageIndex = index;
    if(_locale.languageCode == 'ar') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    try {
      if (Get.context != null) {
        Provider.of<core_loc.LocalizationController>(Get.context!, listen: false).setLanguage(locale, index);
      }
    } catch (_) {}
    try {
      if (Get.context != null) {
        Provider.of<AuthController>(Get.context!, listen: false).setCurrentLanguage(locale.countryCode == 'US'?'en': _locale.countryCode!.toLowerCase());
      }
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _loadCurrentLanguage() async {
    final langCode = sharedPreferences!.getString(AppConstants.languageCodeKey) ??
        sharedPreferences!.getString(AppConstants.languageCode) ??
        AppConstants.languages[0].languageCode!;
    final countryCode = sharedPreferences!.getString(AppConstants.countryCodeKey) ??
        sharedPreferences!.getString(AppConstants.countryCode) ??
        AppConstants.languages[0].countryCode;

    _locale = Locale(langCode, countryCode);
    for(int index=0; index<AppConstants.languages.length; index++) {
      if(AppConstants.languages[index].languageCode == _locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    _isLtr = _locale.languageCode != 'ar';
    _languages = [];
    _languages.addAll(AppConstants.languages);
    notifyListeners();
  }

  Future<void> _saveLanguage(Locale locale) async {
    await sharedPreferences!.setString(AppConstants.languageCodeKey, locale.languageCode);
    if (locale.countryCode != null) {
      await sharedPreferences!.setString(AppConstants.countryCodeKey, locale.countryCode!);
    }
    await sharedPreferences!.setString(AppConstants.languageCode, locale.languageCode);
    if (locale.countryCode != null) {
      await sharedPreferences!.setString(AppConstants.countryCode, locale.countryCode!);
    }
  }

  String? getCurrentLanguage() {
    return sharedPreferences!.getString(AppConstants.countryCodeKey) ??
        sharedPreferences!.getString(AppConstants.countryCode) ??
        "TD";
  }
}

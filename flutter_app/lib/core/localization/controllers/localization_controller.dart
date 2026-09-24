import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:multishop_tchad/core/constants/app_constants.dart';

class LocalizationController extends ChangeNotifier {
  final SharedPreferences? sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  int? _languageIndex;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int? get languageIndex => _languageIndex;

  void setLanguage(Locale locale) {
    _locale = locale;
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  Future<void> _loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences!.getString(AppConstants.languageCodeKey) ?? AppConstants.languages[0].languageCode!,
      sharedPreferences!.getString(AppConstants.countryCodeKey) ?? AppConstants.languages[0].countryCode,
    );
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    notifyListeners();
  }

  Future<void> _saveLanguage(Locale locale) async {
    sharedPreferences!.setString(AppConstants.languageCodeKey, locale.languageCode);
    sharedPreferences!.setString(AppConstants.countryCodeKey, locale.countryCode!);
  }

  String? getCurrentLanguage() {
    return sharedPreferences!.getString(AppConstants.countryCodeKey) ?? "TD";
  }
}

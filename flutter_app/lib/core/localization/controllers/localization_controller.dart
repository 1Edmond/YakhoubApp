import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:multishop_tchad/core/constants/app_constants.dart';
import 'package:multishop_tchad/core/localization/models/language_model.dart';

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

  List<LanguageModel> get languages => AppConstants.languages;

  void setLanguage(Locale locale, [int? index]) {
    _locale = locale;
    _isLtr = _locale.languageCode != 'ar';
    if (index != null) {
      _languageIndex = index;
    } else {
      for (int i = 0; i < AppConstants.languages.length; i++) {
        if (AppConstants.languages[i].languageCode == locale.languageCode) {
          _languageIndex = i;
          break;
        }
      }
    }
    _saveLanguage(_locale);
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
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
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

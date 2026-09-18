import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VaultController extends ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  VaultController({required this.sharedPreferences}) {
    _loadVaultState();
  }

  static const String _pinHashKey = 'vault_pin_hash';
  static const String _enabledFeaturesKey = 'vault_enabled_features';

  String? _pinHash;
  List<String> _enabledFeatures = [];

  String? get pinHash => _pinHash;
  List<String> get enabledFeatures => _enabledFeatures;
  bool get isVaultUnlocked => _pinHash != null;
  bool isFeatureEnabled(String feature) => _enabledFeatures.contains(feature);

  void _loadVaultState() {
    _pinHash = sharedPreferences!.getString(_pinHashKey);
    final featuresJson = sharedPreferences!.getString(_enabledFeaturesKey);
    if (featuresJson != null) {
      _enabledFeatures = List<String>.from(featuresJson.split(','));
    }
    notifyListeners();
  }

  Future<bool> setPin(String pin) async {
    // In production, use a proper hash like bcrypt
    _pinHash = pin.hashCode.toString();
    await sharedPreferences!.setString(_pinHashKey, _pinHash!);
    notifyListeners();
    return true;
  }

  bool verifyPin(String pin) {
    return _pinHash == pin.hashCode.toString();
  }

  Future<void> toggleFeature(String feature, bool enabled) async {
    if (enabled) {
      if (!_enabledFeatures.contains(feature)) {
        _enabledFeatures.add(feature);
      }
    } else {
      _enabledFeatures.remove(feature);
    }
    await sharedPreferences!.setString(_enabledFeaturesKey, _enabledFeatures.join(','));
    notifyListeners();
  }

  void lockVault() {
    _pinHash = null;
    notifyListeners();
  }
}

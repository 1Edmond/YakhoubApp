import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Coffre des fonctionnalités cachées.
/// - Le PIN protège le PANNEAU (déverrouillage par session, jamais persisté comme "ouvert").
/// - Les fonctionnalités activées restent actives après redémarrage.
/// - Le PIN est salé + étiré (HMAC-SHA256, 20 000 itérations) ; ce n'est PAS un secret de niveau serveur.
class VaultController extends ChangeNotifier {
  VaultController({required SharedPreferences sharedPreferences, DateTime Function()? now})
      : _prefs = sharedPreferences,
        _now = now ?? DateTime.now {
    _load();
  }

  static const _pinHashKey = 'vault_pin_hash_v2';
  static const _saltKey = 'vault_pin_salt_v2';
  static const _featuresKey = 'vault_enabled_features_v2';
  static const _legacyHashKey = 'vault_pin_hash';
  static const _legacyFeaturesKey = 'vault_enabled_features';
  static const int minPinLength = 6;
  static const int maxAttempts = 5;
  static const Duration lockDuration = Duration(minutes: 5);
  static const int _iterations = 20000;

  final SharedPreferences _prefs;
  final DateTime Function() _now;

  String? _pinHash;
  String? _salt;
  final Set<String> _enabled = {};
  bool _unlocked = false;
  int _failedAttempts = 0;
  DateTime? _lockedUntil;

  bool get hasPin => _pinHash != null;
  bool get isUnlocked => _unlocked;
  bool get isLockedOut => _lockedUntil != null && _now().isBefore(_lockedUntil!);
  Set<String> get enabledFeatures => Set.unmodifiable(_enabled);
  bool isFeatureEnabled(String feature) => _enabled.contains(feature);

  void _load() {
    // l'ancien PIN (String.hashCode, non sûr) est abandonné
    _prefs.remove(_legacyHashKey);
    _prefs.remove(_legacyFeaturesKey);

    _pinHash = _prefs.getString(_pinHashKey);
    _salt = _prefs.getString(_saltKey);
    _enabled
      ..clear()
      ..addAll(_prefs.getStringList(_featuresKey) ?? const []);
  }

  /// Crée le PIN (première fois) ou le remplace (si le coffre est déverrouillé).
  Future<bool> setPin(String pin) async {
    if (pin.length < minPinLength || int.tryParse(pin) == null) return false;
    if (hasPin && !_unlocked) return false;

    final rnd = Random.secure();
    _salt = base64.encode(List<int>.generate(16, (_) => rnd.nextInt(256)));
    _pinHash = _hash(pin, _salt!);
    await _prefs.setString(_saltKey, _salt!);
    await _prefs.setString(_pinHashKey, _pinHash!);
    _unlocked = true;
    notifyListeners();
    return true;
  }

  bool verifyPin(String pin) {
    if (!hasPin || isLockedOut) return false;

    final ok = _constantTimeEquals(_hash(pin, _salt!), _pinHash!);
    if (ok) {
      _failedAttempts = 0;
      _lockedUntil = null;
      _unlocked = true;
    } else {
      _failedAttempts++;
      if (_failedAttempts >= maxAttempts) {
        _lockedUntil = _now().add(lockDuration);
        _failedAttempts = 0;
      }
    }
    notifyListeners();
    return ok;
  }

  Future<void> toggleFeature(String feature, bool enabled) async {
    if (!_unlocked) throw StateError('Vault locked');
    enabled ? _enabled.add(feature) : _enabled.remove(feature);
    await _prefs.setStringList(_featuresKey, _enabled.toList()..sort());
    notifyListeners();
  }

  void lock() {
    _unlocked = false;
    notifyListeners();
  }

  String _hash(String pin, String salt) {
    final key = utf8.encode(salt);
    var digest = Hmac(sha256, key).convert(utf8.encode(pin)).bytes;
    for (var i = 0; i < _iterations; i++) {
      digest = Hmac(sha256, key).convert(digest).bytes;
    }
    return base64.encode(digest);
  }

  bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}

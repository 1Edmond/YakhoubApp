import 'package:flutter/material.dart';

class GuestModeController extends ChangeNotifier {
  bool _isGuestMode = false;
  bool get isGuestMode => _isGuestMode;

  void setGuestMode(bool value) {
    _isGuestMode = value;
    notifyListeners();
  }
}

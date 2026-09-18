import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vault_controller.dart';

class VaultGuard {
  static const int _requiredTaps = 7;

  bool canAccess(BuildContext context) {
    final controller = context.read<VaultController>();
    return controller.isVaultUnlocked;
  }
}

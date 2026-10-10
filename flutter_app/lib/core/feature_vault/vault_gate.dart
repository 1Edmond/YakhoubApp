import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/core/feature_vault/vault_controller.dart';

class VaultGate extends StatelessWidget {
  final String feature;
  final Widget child;

  const VaultGate({Key? key, required this.feature, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vault = Provider.of<VaultController>(context);
    if (!vault.isFeatureEnabled(feature)) {
      return const SizedBox.shrink();
    }
    return child;
  }
}

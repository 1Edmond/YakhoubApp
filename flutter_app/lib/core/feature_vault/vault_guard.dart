import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'vault_controller.dart';
import 'vault_feature.dart';

class VaultGuard {
  const VaultGuard(this._vault);
  final VaultController _vault;

  bool canUse(String feature) => _vault.isFeatureEnabled(feature);

  /// Pour GoRouter.redirect : renvoie [fallback] si la route appartient à une fonctionnalité désactivée.
  String? redirectFor(String location, {required String fallback}) {
    final feature = VaultFeature.featureForLocation(location);
    if (feature == null || canUse(feature)) return null;
    return fallback;
  }
}

/// Masque son enfant tant que la fonctionnalité du vault n'est pas activée
/// (tuiles de menu, sections de la page d'accueil, boutons...).
class VaultGate extends StatelessWidget {
  const VaultGate({super.key, required this.feature, required this.child, this.fallback});

  final String feature;
  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    final enabled = context.select<VaultController, bool>((v) => v.isFeatureEnabled(feature));
    return enabled ? child : (fallback ?? const SizedBox.shrink());
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/core/feature_vault/vault_controller.dart';

class VaultPanelScreen extends StatelessWidget {
  const VaultPanelScreen({super.key});

  static const List<Map<String, String>> _features = [
    {'key': 'auction', 'label': 'Enchères'},
    {'key': 'wallet', 'label': 'Portefeuille'},
    {'key': 'review', 'label': 'Avis produits'},
    {'key': 'loyalty', 'label': 'Points de fidélité'},
    {'key': 'coupon', 'label': 'Coupons'},
    {'key': 'deal', 'label': 'Offres flash'},
    {'key': 'blog', 'label': 'Blog'},
    {'key': 'compare', 'label': 'Comparaison produits'},
    {'key': 'restock', 'label': 'Alertes de stock'},
    {'key': 'refund', 'label': 'Remboursements'},
    {'key': 'reorder', 'label': 'Recommander'},
    {'key': 'support', 'label': 'Support'},
    {'key': 'vat_tax', 'label': 'TVA'},
    {'key': 'wallet', 'label': 'Wallet'},
    {'key': 'ai_shopping', 'label': 'IA Shopping'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feature Vault')),
      body: Consumer<VaultController>(
        builder: (context, controller, _) => ListView(
          padding: const EdgeInsets.all(16),
          children: _features.map((feature) {
            final enabled = controller.isFeatureEnabled(feature['key']!);
            return SwitchListTile(
              title: Text(feature['label']!),
              value: enabled,
              onChanged: (v) => controller.toggleFeature(feature['key']!, v),
            );
          }).toList(),
        ),
      ),
    );
  }
}

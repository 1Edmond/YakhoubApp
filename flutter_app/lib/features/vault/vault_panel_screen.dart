import 'package:flutter/material.dart';
import 'package:multishop_tchad/core/feature_vault/vault_controller.dart';
import 'package:multishop_tchad/core/feature_vault/vault_feature.dart';
import 'package:multishop_tchad/core/localization/language_constrants.dart';
import 'package:provider/provider.dart';

/// Panneau développeur : création / saisie du PIN, puis activation des fonctionnalités hors CDC.
class VaultPanelScreen extends StatefulWidget {
  const VaultPanelScreen({super.key});

  @override
  State<VaultPanelScreen> createState() => _VaultPanelScreenState();
}

class _VaultPanelScreenState extends State<VaultPanelScreen> {
  final TextEditingController _pin = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _submit(VaultController vault) async {
    final pin = _pin.text.trim();
    if (!vault.hasPin) {
      final ok = await vault.setPin(pin);
      setState(() => _error = ok ? null : getTranslated('vault_pin_invalid', context));
    } else {
      final ok = vault.verifyPin(pin);
      setState(() => _error = ok
          ? null
          : (vault.isLockedOut ? getTranslated('vault_locked_out', context) : getTranslated('vault_wrong_pin', context)));
    }
    _pin.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VaultController>(builder: (context, vault, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated('vault_title', context) ?? ''),
          actions: [
            if (vault.isUnlocked)
              IconButton(icon: const Icon(Icons.lock), tooltip: getTranslated('vault_lock', context), onPressed: vault.lock),
          ],
        ),
        body: vault.isUnlocked ? _features(vault) : _pinForm(vault),
      );
    });
  }

  Widget _pinForm(VaultController vault) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(getTranslated(vault.hasPin ? 'vault_enter_pin' : 'vault_create_pin', context) ?? ''),
        const SizedBox(height: 16),
        TextField(
          controller: _pin,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 12,
          textAlign: TextAlign.center,
          onSubmitted: (_) => _submit(vault),
          decoration: InputDecoration(hintText: getTranslated('vault_pin_hint', context), errorText: _error),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: vault.isLockedOut ? null : () => _submit(vault),
          child: Text(getTranslated('confirm', context) ?? ''),
        ),
      ]),
    );
  }

  Widget _features(VaultController vault) {
    return ListView(
      children: VaultFeature.all.map((key) {
        return SwitchListTile(
          title: Text(getTranslated('vault_feature_$key', context) ?? key),
          value: vault.isFeatureEnabled(key),
          onChanged: (v) => vault.toggleFeature(key, v),
        );
      }).toList(),
    );
  }
}

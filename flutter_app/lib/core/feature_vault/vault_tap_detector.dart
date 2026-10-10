import 'package:flutter/material.dart';
import 'package:multishop_tchad/features/vault/vault_panel_screen.dart';

/// Ouvre le panneau du vault après [requiredTaps] appuis rapprochés sur [child]
/// (à placer autour du texte de version : Plus/Paramètres côté client, Profil côté vendeur).
class VaultTapDetector extends StatefulWidget {
  const VaultTapDetector({super.key, required this.child, this.requiredTaps = 7});

  final Widget child;
  final int requiredTaps;

  @override
  State<VaultTapDetector> createState() => _VaultTapDetectorState();
}

class _VaultTapDetectorState extends State<VaultTapDetector> {
  static const Duration _window = Duration(seconds: 3);
  int _taps = 0;
  DateTime? _first;

  void _onTap() {
    final now = DateTime.now();
    if (_first == null || now.difference(_first!) > _window) {
      _first = now;
      _taps = 0;
    }
    _taps++;
    if (_taps >= widget.requiredTaps) {
      _taps = 0;
      _first = null;
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VaultPanelScreen()));
    }
  }

  @override
  Widget build(BuildContext context) =>
      GestureDetector(behavior: HitTestBehavior.opaque, onTap: _onTap, child: widget.child);
}

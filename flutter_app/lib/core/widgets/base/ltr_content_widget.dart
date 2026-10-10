import 'package:flutter/material.dart';

/// Force LTR pour un contenu purement numérique (ex. "1 500 FCFA") au sein d'une page RTL.
/// À ne PAS utiliser autour d'un libellé traduit.
class LtrContent extends StatelessWidget {
  final Widget child;
  const LtrContent({super.key, required this.child});

  @override
  Widget build(BuildContext context) =>
      Directionality(textDirection: TextDirection.ltr, child: child);
}

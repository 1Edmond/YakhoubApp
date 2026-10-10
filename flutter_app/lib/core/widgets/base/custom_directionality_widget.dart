import 'package:flutter/material.dart';

/// Conserve la direction de lecture courante (LTR en français, RTL en arabe).
/// Ancien comportement : forçait TextDirection.ltr partout, ce qui cassait l'arabe.
/// Pour un contenu strictement numérique (prix, téléphone, N° de commande), utiliser [LtrContent].
class CustomDirectionalityWidget extends StatelessWidget {
  final Widget child;
  const CustomDirectionalityWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => child;
}

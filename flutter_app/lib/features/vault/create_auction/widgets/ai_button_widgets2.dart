import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLastTab;
  final bool isLoading;

  const NextButton({
    super.key,
    this.onTap,
    this.isLastTab = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AiLoadingState extends StatelessWidget {
  const AiLoadingState({super.key});
  @override
  Widget build(BuildContext context) { return Container(); }
}

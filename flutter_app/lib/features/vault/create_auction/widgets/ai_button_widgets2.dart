import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isLastTab;
  final bool isLoading;

  const NextButton({
    Key? key,
    this.onTap,
    this.isLastTab = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AiLoadingState extends StatelessWidget {
  const AiLoadingState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) { return Container(); }
}

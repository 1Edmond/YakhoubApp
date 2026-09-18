import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/core/constants/custom_themes.dart';

class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_top, size: 80, color: Colors.orange),
              const SizedBox(height: 24),
              Text(
                'Votre compte vendeur est en attente de validation',
                style: titilliumBold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Un administrateur va examiner votre dossier. Vous serez notifié dès que votre compte sera activé.",
                style: textRegular.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => launchUrl(Uri.parse('mailto:support@multishop.tchad')),
                icon: const Icon(Icons.support_agent),
                label: const Text('Contacter le support'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

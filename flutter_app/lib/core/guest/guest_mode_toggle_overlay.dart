import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/customer/splash/screens/splash_screen.dart';

class GuestModeToggleOverlay extends StatelessWidget {
  final Widget child;
  const GuestModeToggleOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 100,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: Consumer<GuestModeController>(
              builder: (context, guestModeController, _) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: guestModeController.isGuestMode ? Colors.green : Colors.grey.withValues(alpha:0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.person_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        'Guest Mode',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Switch(
                        value: guestModeController.isGuestMode,
                        onChanged: (value) {
                          guestModeController.setGuestMode(value);
                          if (value) {
                             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SplashScreen()));
                          }
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green[300],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multishop_tchad/core/theme/controllers/theme_controller.dart';

class ColorHelper {
  static Color getTextColor(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false).darkTheme
        ? Colors.white
        : Colors.black;
  }

  static Color getSecondaryTextColor(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false).darkTheme
        ? Colors.grey[400]!
        : Colors.grey[600]!;
  }

  static Color getPrimaryColor(BuildContext context) =>
      Theme.of(context).primaryColor;

  static Color getIconColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  /// Vendor app compatibility - blends two colors by factor (0.0 = color1, 1.0 = color2)
  static Color blendColors(Color color1, Color color2, double factor) {
    return Color.lerp(color1, color2, factor) ?? color1;
  }

  static Color? hexCodeToColor(String? code){
    int? colorCode = int.tryParse(code?.replaceAll('#', '0xff') ?? '');
    return colorCode == null ? null : Color(colorCode);
  }

  static Color darken(Color color, double amount) {
    assert(amount >= 0 && amount <= 1, "Amount must be between 0 and 1");
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("import 'package:flutter_sixvalley_ecommerce/core/guest/guest_mode_toggle_overlay.dart';", "")

content = content.replace('''          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: SafeArea(
                  top: false, child: GuestModeToggleOverlay(child: child!)),
            );
          },''',
'''          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: SafeArea(top: false, child: child!),
            );
          },''')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

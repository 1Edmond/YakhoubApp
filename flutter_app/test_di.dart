import 'package:flutter_sixvalley_ecommerce/core/di/di_container.dart' as di;
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await di.init();
    print('SUCCESS');
  } catch (e, stack) {
    print('ERROR: $e');
  }
}

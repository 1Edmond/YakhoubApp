import 'package:multishop_tchad/core/di/di_container.dart' as di;
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await di.init();
    // print('SUCCESS');
  } catch (e) {
    // print('ERROR: $e');
  }
}

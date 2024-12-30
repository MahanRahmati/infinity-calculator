import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_native_splash/service_native_splash.dart';
import 'package:service_system_chrome/service_system_chrome.dart';

import 'src/app.dart';

/// The main is the entry point of the application.
Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await NativeSplash.instance.init(widgetsBinding);
  SystemChromes.setSystemUIOverlayStyle();
  SystemChromes.setEnabledSystemUIMode();
  SystemChromes.setPreferredOrientations();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

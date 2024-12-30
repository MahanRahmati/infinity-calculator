import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_native_splash/service_native_splash.dart';
import 'package:service_system_chrome/service_system_chrome.dart';

import 'src/app.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  SystemChromes.setSystemUIOverlayStyle();
  SystemChromes.setEnabledSystemUIMode();
  SystemChromes.setPreferredOrientations();

  await NativeSplash.instance.init(widgetsBinding);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

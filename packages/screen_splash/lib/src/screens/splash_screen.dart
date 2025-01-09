import 'package:app_router/app_router.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';
import 'package:service_native_splash/service_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _removeNativeSplashAndNavigate();
  }

  void _removeNativeSplashAndNavigate() {
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      NativeSplash.instance.remove();
      Routes.goToHome(context);
    });
  }

  @override
  Widget build(final BuildContext context) {
    final Color backgroundColor = InfinityColors.getBackgroundColor(
      context,
      BackgroundType.window,
    );
    return ColoredBox(
      color: backgroundColor,
      child: const Center(
        child: SizedBox(),
      ),
    );
  }
}

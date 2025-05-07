import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/splash_screen.dart';

import '../../features/start_up/presenation/screens/on_boarding_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );

      case OnBoardingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return OnBoardingScreen();
          },
        );

      default:
        return unDefinedRoute();
    }
  }

  Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('no_route'.tr()),
        ),
        body: Center(
          child: Text('no_route'.tr()),
        ),
      ),
    );
  }
}

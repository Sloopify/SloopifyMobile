import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/otp_code_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/verify_account_screen.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/splash_screen.dart';

import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
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
      case WelcomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen();
          },
        );
      case SignupScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SignupScreen();
          },
        );
      case VerifyAccountScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return VerifyAccountScreen(mobileNumber: arg['mobileNumber'],email: arg['email'],fromForgetPassword: arg['fromPassword'],);
          },
        );
      case OtpCodeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return OtpCodeScreen();
          },
        );
      case SignInScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return SignInScreen();
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

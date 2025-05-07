import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/app_configuation/app_configuation.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/on_boarding_screen.dart';

import 'core/local_storage/preferene_utils.dart';
import 'core/locator/service_locator.dart' as sl;
import 'core/managers/language_managers.dart';
import 'core/managers/theme_manager.dart';
import 'features/start_up/presenation/screens/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await AppConfiguration.initializeCore();
  runApp(
    EasyLocalization(
      supportedLocales: LanguagesManager.languages.values.toList(),
      path: 'assets/locales',
      fallbackLocale: const Locale('en'),
      startLocale: Locale('en'),
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //my emulator Nexus 6 width and height
      designSize: const Size(411.42857142857144, 683.4285714285714),
      builder:
          (_, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: LanguagesManager.languages.values.toList(),
            locale: context.locale,
            theme: AppTheme.getApplicationThemeData(context),
            navigatorKey: navigatorKey,
            home: SplashScreen(
              navigator:navigationPage(context),
            ),
          ),
    );
  }

   navigationPage(BuildContext context) {
    bool? firstTime = PreferenceUtils.getbool('firstTime');
    if (firstTime == true) {
     // Navigator.pushReplacementNamed(context, AppWrapper.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(
        OnBoardingScreen.routeName,
      );

    }
  }

}

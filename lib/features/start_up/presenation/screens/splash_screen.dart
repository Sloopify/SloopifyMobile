import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../../../core/local_storage/preferene_utils.dart';

class SplashScreen extends StatefulWidget {
  final dynamic? navigator;

  const SplashScreen({super.key, this.navigator});

  static const routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, widget.navigator);
  }
@override
  void initState() {
    startTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: ColorManager.white,
      logoWidth: MediaQuery.of(context).size.width * 0.25,
      logo: Image.asset(
        height: 100,
        AssetsManager.logo,
        alignment: Alignment.center,
      ),
      showLoader: false,
      loaderColor: ColorManager.white,
      loadingText: Text(
        'V ${PreferenceUtils.getString('versionNumberKey')}',
        style: AppTheme.headline3.copyWith(
          color: ColorManager.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      // futureNavigator: getFirstScreen(),
    );
  }
}

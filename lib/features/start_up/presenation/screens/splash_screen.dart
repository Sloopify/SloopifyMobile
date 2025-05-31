import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/local_storage/prefernces_key.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/app_wrapper/presentation/screens/app_wrapper.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/on_boarding_screen.dart';

import '../../../../core/local_storage/preferene_utils.dart';
import '../../../auth/presentation/blocs/authentication_bloc/authentication_bloc.dart';

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
    return Timer(duration, ()=>navigationPage(context));
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
        'V 1.0.0',
        style: AppTheme.headline3.copyWith(
          color: ColorManager.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      // futureNavigator: getFirstScreen(),
    );
  }
  void navigationPage(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
    bool? firstTime = PreferenceUtils.getbool(SharedPrefsKey.firstTime);
    if (firstTime==true) {
      Navigator.pushReplacementNamed(context, AppWrapper.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(
        OnBoardingScreen.routeName,
      );

    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/forget_password_cubit/forget_password_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/gender_identity_cubit/gender_identity_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_with_otp_code/login_with_otp_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/gender_identity.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/user_interests.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/login_with_otp_code.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/otp_code_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/verify_account_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/write_otp_code_screen.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/splash_screen.dart';

import '../../features/app_wrapper/presentation/screens/app_wrapper.dart';
import '../../features/auth/presentation/blocs/complete_birthday_cubit/complete_birthday_cubit.dart';
import '../../features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import '../../features/auth/presentation/blocs/user_interets_cubit/user_interests_cubit.dart';
import '../../features/auth/presentation/screens/account_info/birthday_screen.dart';
import '../../features/auth/presentation/screens/account_info/fill_account_screen.dart';
import '../../features/auth/presentation/screens/account_info/referred_day.dart';
import '../../features/auth/presentation/screens/forget_password_screens/change_pawword_screen.dart';
import '../../features/auth/presentation/screens/forget_password_screens/otp_forget_password.dart';
import '../../features/auth/presentation/screens/forget_password_screens/write_otp_forget_password.dart';
import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/home/presentation/screens/home_navigation_screen.dart';
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
      case AppWrapper.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return AppWrapper();
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
            return BlocProvider.value(
              value: arg["signUpCubit"] as SignUpCubit,
              child: VerifyAccountScreen(
                fromForgetPassword: arg['fromPassword'],
              ),
            );
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
      case LoginWithOtpCode.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return LoginWithOtpCode();
          },
        );
      case WriteOtpCodeScreen.routeName:
        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: arg["otpLoginCubit"] as LoginWithOtpCubit,
              child: WriteOtpCodeScreen(),
            );
          },
        );
      case OtpForgetPassword.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return OtpForgetPassword();
          },
        );
      case WriteOtpForgetPassword.routeName:
        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: arg["forgetPasswordCubit"] as ForgetPasswordCubit,
              child: WriteOtpForgetPassword(),
            );
          },
        );
      case ChangePasswordScreen.routeName:
        final arg = routeSettings.arguments as Map;

        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider.value(
              value: arg["forgetPasswordCubit"] as ForgetPasswordCubit,
              child: ChangePasswordScreen(),
            );
          },
        );
      case UserInterests.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) =>
              locator<InterestCubit>()
                ..getAllCategories(),
              child: UserInterests(),
            );
          },
        );
      case GenderIdentity.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => locator<GenderIdentityCubit>(),
              child: GenderIdentity(),
            );
          },
        );
      case BirthdayScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => locator<CompleteBirthdayCubit>(),
              child: BirthdayScreen(),
            );
          },
        );
      case FillAccountScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => locator<UploadPictureCubit>(),
              child: FillAccountScreen(),
            );
          },
        );
      case ReferredDay.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ReferredDay();
          },
        );
      case HomeNavigationScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return HomeNavigationScreen();
          },
        );
      default:
        return unDefinedRoute();
    }
  }

  Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) =>
          Scaffold(
            appBar: AppBar(title: Text('no_route'.tr())),
            body: Center(child: Text('no_route'.tr())),
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/complete_birthday_cubit/complete_birthday_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/gender_identity_cubit/gender_identity_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/user_interets_cubit/user_interests_cubit.dart';

import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/birthday_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/fill_account_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/gender_identity.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/welcome_screen.dart';
import 'package:sloopify_mobile/features/home/presentation/screens/home_navigation_screen.dart';

import '../../../../core/locator/service_locator.dart';
import '../../../auth/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import '../../../auth/presentation/screens/account_info/user_interests.dart';
import '../../../auth/presentation/screens/verify_account_screen.dart';
import '../../../start_up/presenation/screens/splash_screen.dart';

class AppWrapper extends StatelessWidget {
  static const routeName = 'wrapper_scrren';

  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _buildAuthBuilder(state, context);
      },
    );
  }

  Widget _buildAuthBuilder(AuthenticationState state, BuildContext context) {
    if (state is AuthenticationInitial) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is AuthenticatationLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (state is UnauthenticatedState) {
      return WelcomeScreen();
    } else if (state is NotActivatedWithOtpCode) {
      return VerifyAccountScreen();
    } else if (state is NotCompetedInterests) {
      return BlocProvider(
        create: (context) =>
        locator<InterestCubit>()
          ..getAllCategories(),
        child: UserInterests(),
      );
    } else if (state is NotCompletedBirthdayInfo) {
      return BlocProvider(
        create: (context) => locator<CompleteBirthdayCubit>(),
        child: BirthdayScreen(),
      );
    } else if (state is NotCompletedGenderInfo) {
      return BlocProvider(
        create: (context) => locator<GenderIdentityCubit>(),
        child: GenderIdentity(),
      );
    } else if (state is NotCompletedImageInfo) {
      return BlocProvider(
        create: (context) => locator<UploadPictureCubit>(),
        child: FillAccountScreen(),
      );
    } else if (state is AuthenticatedState) {
      return HomeNavigationScreen();
    } else {
      return SplashScreen();
    }
  }
}

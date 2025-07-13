import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/app_configuation/app_configuation.dart';
import 'package:sloopify_mobile/core/managers/route_manager.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_token_use_case.dart';
import 'package:sloopify_mobile/features/friend_list/screen/suggestedFriendListPage.dart';
import 'package:sloopify_mobile/features/start_up/presenation/screens/on_boarding_screen.dart';

import 'core/local_storage/preferene_utils.dart';
import 'core/locator/service_locator.dart' as sl;
import 'core/managers/language_managers.dart';
import 'core/managers/theme_manager.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/presentation/blocs/authentication_bloc/authentication_bloc.dart';
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
      child: MyApp(authRepo: AuthRepoImpl()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo;
  const MyApp({super.key, required this.authRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (context) => authRepo),
        BlocProvider(
          create:
              (context) => AuthenticationBloc(
                authRepository: authRepo,
                verifyTokenUseCase: sl.locator<VerifyTokenUseCase>(),
              ),
        ),
      ],
      child: ScreenUtilInit(
        //my emulator Nexus 6 width and height
        designSize: const Size(411.42857142857144, 683.4285714285714),
        builder:
            (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: LanguagesManager.languages.values.toList(),
              locale: context.locale,
              theme: AppTheme.getApplicationThemeData(context),
              navigatorKey: navigatorKey,
              home: SuggestedFriendListPage(),
              onGenerateRoute: AppRouter().onGenerateRoute,
            ),
      ),
    );
  }
}

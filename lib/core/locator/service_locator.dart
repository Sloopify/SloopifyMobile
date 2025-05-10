import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sloopify_mobile/core/api_service/base_api_service.dart';
import 'package:sloopify_mobile/core/api_service/network_service_dio.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  ///
  ///external
  ///
  locator.registerLazySingleton<BaseApiService>(() => NetworkServiceDio());
  locator.registerLazySingleton(() => InternetConnectionChecker.instance);

  ////blocs
  locator.registerFactory(() => VerifyAccountCubit());
  locator.registerFactory(() => SignUpCubit());
}

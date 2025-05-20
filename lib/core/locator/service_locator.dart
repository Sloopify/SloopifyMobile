import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sloopify_mobile/core/api_service/base_api_service.dart';
import 'package:sloopify_mobile/core/api_service/network_service_dio.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/account_info/profile_info_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_bloc.dart';
import 'package:sloopify_mobile/features/home/presentation/blocs/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/fetch_comments_bloc/fetch_comments_bloc.dart';

import '../../features/posts/presentation/blocs/comment_reaction_cubit/comment_reactions_cubit.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  ///
  ///external
  ///
  locator.registerLazySingleton<BaseApiService>(() => NetworkServiceDio());
  locator.registerLazySingleton(() => InternetConnectionChecker.instance);

  ////blocs
  locator.registerFactory(() => VerifyAccountCubit());
  locator.registerFactory(() => LoginCubit());
  locator.registerFactory(() => SignUpCubit());
  locator.registerFactory(() => ProfileInfoCubit());
  locator.registerFactory(() => UploadPictureCubit());
  locator.registerFactory(() => HomeNavigationCubit());
  locator.registerFactory(() => CommentInteractionCubit());
  locator.registerFactory(() => CommentFetchBloc());
  locator.registerFactory(() => MessagesBloc());
  locator.registerFactory(() => ChatBloc());
}

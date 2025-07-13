import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sloopify_mobile/core/api_service/base_api_service.dart';
import 'package:sloopify_mobile/core/api_service/network_service_dio.dart';
import 'package:sloopify_mobile/features/auth/data/repositories/account_repo_impl.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/account_repo.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_birthday_usecase.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_gender_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_interests_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_profile_image_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/complete_referred_by_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/email_login_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/get_all_categories_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/get_user_interests_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/phone_login_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/request_code_forget_password.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_otp_code_login.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_token_use_case.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/complete_birthday_cubit/complete_birthday_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/forget_password_cubit/forget_password_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/gender_identity_cubit/gender_identity_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/login_with_otp_code/login_with_otp_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/referred_by_cubit/referred_by_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/signup_cubit/sign_up_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/social_media_login/social_media_login_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account_by_signup_cubit.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/blocs/message_bloc/messages_bloc.dart';
import 'package:sloopify_mobile/features/create_posts/data/create_post_data_provider/create_post_data_provider.dart';
import 'package:sloopify_mobile/features/create_posts/data/create_post_repo/create_post_repo_impl.dart';
import 'package:sloopify_mobile/features/create_posts/domain/repositories/create_post_repo.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/create_place_use_case.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/create_post_use_case.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/get_all_user_places_use_case.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/search_places.dart';
import 'package:sloopify_mobile/features/create_posts/domain/use_cases/update_place_use_caes.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_story/data/create_stoty_provider/create_story_data_provider.dart';
import 'package:sloopify_mobile/features/create_story/data/repository/create_story_repo.dart';
import 'package:sloopify_mobile/features/create_story/domain/repository/create_story_repository.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/get_story_friends_use_case.dart';
import 'package:sloopify_mobile/features/create_story/domain/use_cases/search_story_friends_use_case.dart';
import 'package:sloopify_mobile/features/home/presentation/blocs/home_navigation_cubit/home_navigation_cubit.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/fetch_comments_bloc/fetch_comments_bloc.dart';

import '../../features/auth/data/account_data_provider/account_data_provider.dart';
import '../../features/auth/data/repositories/auth_repo_impl.dart';
import '../../features/auth/domain/reposritory/auth_repo.dart';
import '../../features/auth/domain/use_cases/opt_login_use_case.dart';
import '../../features/auth/domain/use_cases/register_otp_use_case.dart';
import '../../features/auth/domain/use_cases/verify_code_forget_password_use_case.dart';
import '../../features/auth/domain/use_cases/verify_otp_register_use_case.dart';
import '../../features/auth/presentation/blocs/user_interets_cubit/user_interests_cubit.dart';
import '../../features/create_posts/domain/use_cases/get_activities_by_categories_name.dart';
import '../../features/create_posts/domain/use_cases/get_categories_activities.dart';
import '../../features/create_posts/domain/use_cases/get_feelings_use_case.dart';
import '../../features/create_posts/domain/use_cases/get_friends_list_use_case.dart';
import '../../features/create_posts/domain/use_cases/get_user_place_by_id_use_case.dart';
import '../../features/create_posts/domain/use_cases/search_activities_by_name_use_case.dart';
import '../../features/create_posts/domain/use_cases/search_categories_activiries_by_name.dart';
import '../../features/create_posts/domain/use_cases/search_feelings_use_case.dart';
import '../../features/create_posts/domain/use_cases/search_friend_use_case.dart';
import '../../features/posts/presentation/blocs/comment_reaction_cubit/comment_reactions_cubit.dart';
import '../network/check_internet.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  ////blocs
  locator.registerFactory(() => VerifyAccountCubit());
  locator.registerFactory(
    () =>
        LoginCubit(emailLoginUseCase: locator(), phoneLoginUseCase: locator()),
  );
  locator.registerFactory(
    () => SignUpCubit(
      signupUseCase: locator(),
    ),
  );
  locator.registerFactory(
        () => VerifyAccountBySignupCubit(
      registerOtpUseCase: locator(),
      verifyOtpRegisterUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => LoginWithOtpCubit(
      verifyOtpCodeLogin: locator(),
      optLoginUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => ForgetPasswordCubit(
      changePasswordUseCase: locator(),
      verifyCodeForgetPasswordUseCase: locator(),
      requestCodeForgetPasswordUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => UploadPictureCubit(completeProfileImageUseCase: locator()),
  );
  locator.registerFactory(() => HomeNavigationCubit());
  locator.registerFactory(() => CommentInteractionCubit());
  locator.registerFactory(() => CommentFetchBloc());
  locator.registerFactory(() => MessagesBloc());
  locator.registerFactory(() => ChatBloc());
  locator.registerFactory(
    () => PostFriendsCubit(
      getStoryFriendsUseCase: locator(),
      searchStoryFriendsUseCase: locator(),
      getFriendsListUseCase: locator(),
      searchFriendsListUseCase: locator(),
    ),
  );
  locator.registerFactory(() => CreatePostCubit(createPostUseCase: locator()));
  locator.registerFactory(
    () => FeelingsActivitiesCubit(
      getActivitiesByCategoriesName: locator(),
      getCategoriesActivities: locator(),
      getFeelingsUseCase: locator(),
      searchActivitiesByNameUseCase: locator(),
      searchCategoriesActivitiesByName: locator(),
      searchFeelingsUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => AuthenticationBloc(
      authRepository: locator(),
      verifyTokenUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => InterestCubit(
      completeInterestsUseCase: locator(),
      getUserInterestsUseCase: locator(),
      getAllCategoriesUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GenderIdentityCubit(completeGenderUseCase: locator()),
  );
  locator.registerFactory(
    () => CompleteBirthdayCubit(completeBirthdayUseCase: locator()),
  );
  locator.registerFactory(
    () => ReferredByCubit(completeReferredByUseCase: locator()),
  );
  locator.registerFactory(() => SocialMediaLoginCubit());
  locator.registerFactory(
    () => AddLocationCubit(
      updatePlaceUseCase: locator(),
      createPlaceUseCase:  locator(),
      searchPlaces:  locator(),
      getUserPlaceByIdUseCase:  locator(),
      getAllUserPlacesUseCase:  locator(),
    ),
  );

  ///
  ///use cases
  ////////
  locator.registerLazySingleton(() => SignupUseCase(accountsRepo: locator()));
  locator.registerLazySingleton(
    () => RegisterOtpUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => EmailLoginUseCase(accountsRepo: locator(), authRepo: locator()),
  );

  locator.registerLazySingleton(
    () => PhoneLoginUseCase(accountsRepo: locator(), authRepo: locator()),
  );
  locator.registerLazySingleton(
    () => VerifyOtpCodeLogin(accountsRepo: locator(), authRepo: locator()),
  );
  locator.registerLazySingleton(() => OptLoginUseCase(accountsRepo: locator()));
  locator.registerLazySingleton(
    () => VerifyOtpRegisterUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => VerifyTokenUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetUserInterestsUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetAllCategoriesUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => CompleteInterestsUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => CompleteBirthdayUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => CompleteGenderUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => CompleteProfileImageUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => CompleteReferredByUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => RequestCodeForgetPasswordUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => VerifyCodeForgetPasswordUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => ChangePasswordUseCase(accountsRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetActivitiesByCategoriesName(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetCategoriesActivities(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetFeelingsUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetFriendsListUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => SearchActivitiesByNameUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => SearchCategoriesActivitiesByName(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => SearchFeelingsUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => SearchFriendsListUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetAllUserPlacesUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetUserPlaceByIdUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(() => SearchPlaces(createPostRepo: locator()));
  locator.registerLazySingleton(
    () => CreatePlaceUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
    () => UpdatePlaceUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
        () => CreatePostUseCase(createPostRepo: locator()),
  );
  locator.registerLazySingleton(
        () => GetStoryFriendsUseCase(createStoryRepo: locator()),
  );
  locator.registerLazySingleton(
        () => SearchStoryFriendsUseCase(createStoryRepo: locator()),
  );

  ///
  ///Repositories
  ////////
  locator.registerLazySingleton<AccountRepo>(
    () => AccountRepoImpl(accountsDataProvider: locator()),
  );
  locator.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());
  locator.registerLazySingleton<CreatePostRepo>(
    () => CreatePostRepoImpl(createPostDataProvider: locator()),
  );
  locator.registerLazySingleton<CreateStoryRepo>(
        () => CreateStoryRepoImpl(createStoryDataProvider: locator()),
  );
  ////
  //////data source
  ////
  locator.registerLazySingleton<CreatePostDataProvider>(
    () => CreatePosDataProviderImpl(client: locator()),
  );
  locator.registerLazySingleton<AccountsDataProvider>(
    () => AccountsDataProviderImpl(client: locator()),
  );
  locator.registerLazySingleton<CreateStoryDataProvider>(
        () => CreateStoryDataProviderImpl(client: locator()),
  );

  ///
  ///core
  ///
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: locator()),
  );

  ///
  ///external
  ///
  locator.registerLazySingleton<BaseApiService>(() => NetworkServiceDio());
  locator.registerLazySingleton(() => InternetConnectionChecker.instance);
}

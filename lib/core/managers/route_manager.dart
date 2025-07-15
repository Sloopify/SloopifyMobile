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
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/crop_image_cubit/crop_image_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/rotate_photo_cubit/rotate_photo_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/feelings_list_widget.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/drawing_story/drawing_story_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/play_audio_cubit/play_audio_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
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
import '../../features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import '../../features/create_posts/presentation/screens/activities_by_categories.dart';
import '../../features/create_posts/presentation/screens/create_post.dart';
import '../../features/create_posts/presentation/screens/create_album_screen.dart';
import '../../features/create_posts/presentation/screens/edit_media/crop_image_options.dart';
import '../../features/create_posts/presentation/screens/edit_media/edit_media_screen.dart';
import '../../features/create_posts/presentation/screens/edit_media/rotate_photo_screen.dart';
import '../../features/create_posts/presentation/screens/feelings_activities_screen.dart';
import '../../features/create_posts/presentation/screens/freinds_list.dart';
import '../../features/create_posts/presentation/screens/mention_friends.dart';
import '../../features/create_posts/presentation/screens/places/add_new_place.dart';
import '../../features/create_posts/presentation/screens/places/all_user_places_screen.dart';
import '../../features/create_posts/presentation/screens/places/location_map_screen.dart';
import '../../features/create_posts/presentation/screens/post_audience_screen.dart';
import '../../features/create_story/presentation/screens/camera_capture.dart';
import '../../features/create_story/presentation/screens/create_Story_first_step.dart';
import '../../features/create_story/presentation/screens/select_media_gallery_story.dart';
import '../../features/create_story/presentation/screens/story_audience/choose_story_audience.dart'
    show StoryAudienceScreen;
import '../../features/create_story/presentation/screens/story_audience/story_friends_list.dart';
import '../../features/create_story/presentation/screens/story_audios.dart';
import '../../features/create_story/presentation/screens/story_editor_screen.dart';
import '../../features/create_story/presentation/screens/story_feelings_list.dart';
import '../../features/create_story/presentation/screens/text_story_editor.dart';
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
            return VerifyAccountScreen(
              email: arg["email"] as String?,
              phoneNumber: arg["phoneNumber"] as String?,
              fromSignUp: arg["fromSignUp"] as bool,
            );
          },
        );
      case OtpCodeScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return OtpCodeScreen(
              email: arg["email"] as String?,
              phoneNumber: arg["phoneNumber"] as String?,
              fromSignUp: arg["fromSignUp"] as bool,
            );
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
              create: (context) => locator<InterestCubit>()..getAllCategories(),
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
      case CreatePost.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return CreatePost();
          },
        );
      case AlbumPhotosScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value: arg["edit_media_cubit"] as EditMediaCubit,
                ),
              ],
              child: AlbumPhotosScreen(),
            );
          },
        );
      case PostAudienceScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value: arg["post_friends_cubit"] as PostFriendsCubit,
                ),
              ],
              child: PostAudienceScreen(),
            );
          },
        );
      case FriendsList.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value: arg["post_friends_cubit"] as PostFriendsCubit,
                ),
              ],
              child: FriendsList(),
            );
          },
        );
      case FeelingsActivitiesScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value:
                      arg["feelings_activities_cubit"]
                          as FeelingsActivitiesCubit,
                ),
              ],
              child: FeelingsActivitiesScreen(),
            );
          },
        );
      case StoryFeelingsList.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["story_editor_cubit"] as StoryEditorCubit,
                ),
                BlocProvider.value(
                  value:
                      arg["feelings_activities_cubit"]
                          as FeelingsActivitiesCubit,
                ),
              ],
              child: StoryFeelingsList(),
            );
          },
        );
      case ActivitiesByCategories.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value:
                      arg["feelings_activities_cubit"]
                          as FeelingsActivitiesCubit,
                ),
              ],
              child: ActivitiesByCategories(name: arg["categoryName"]),
            );
          },
        );
      case MentionFriends.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value: arg["post_friends_cubit"] as PostFriendsCubit,
                ),
              ],
              child: MentionFriends(),
            );
          },
        );
      case AllUserPlacesScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                arg["fromStory"] == false
                    ? BlocProvider.value(
                      value: arg["create_post_cubit"] as CreatePostCubit,
                    )
                    : BlocProvider.value(
                      value: arg["story_editor_cubit"] as StoryEditorCubit,
                    ),
                BlocProvider.value(
                  value:
                      (arg["add_location_cubit"] as AddLocationCubit)
                        ..getAllUserPlaces(),
                ),
              ],
              child: AllUserPlacesScreen(fromStory: arg["fromStory"] ?? false),
            );
          },
        );
      case AddNewPlace.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["add_location_cubit"] as AddLocationCubit,
                ),
              ],
              child: AddNewPlace(),
            );
          },
        );
      case LocationMapScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["add_location_cubit"] as AddLocationCubit,
                ),
              ],
              child: LocationMapScreen(),
            );
          },
        );
      case EditMediaScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["create_post_cubit"] as CreatePostCubit,
                ),
                BlocProvider.value(
                  value: arg["edit_media_cubit"] as EditMediaCubit,
                ),
              ],
              child: EditMediaScreen(initialIndex: arg["initialIndex"]),
            );
          },
        );
      case CropScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["edit_media_cubit"] as EditMediaCubit,
                ),
                BlocProvider(
                  create: (context) => arg["CropCubit"] as CropCubit,
                ),
              ],
              child: CropScreen(index: arg["initialIndex"]),
            );
          },
        );
      case RotateImageScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["edit_media_cubit"] as EditMediaCubit,
                ),
                BlocProvider(
                  create: (context) => arg["rotate_cubit"] as RotateMediaCubit,
                ),
              ],
              child: RotateImageScreen(index: arg["initialIndex"]),
            );
          },
        );
      case StoryAudienceScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["story_editor_cubit"] as StoryEditorCubit,
                ),
                BlocProvider.value(
                  value: arg["post_friends_cubit"] as PostFriendsCubit,
                ),
              ],
              child: StoryAudienceScreen(),
            );
          },
        );
      case StoryFriendsList.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["story_editor_cubit"] as StoryEditorCubit,
                ),
                BlocProvider.value(
                  value: arg["post_friends_cubit"] as PostFriendsCubit,
                ),
              ],
              child: StoryFriendsList(),
            );
          },
        );
      case StoryAudios.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: arg["story_editor_cubit"] as StoryEditorCubit,
                ),
                BlocProvider(
                  create:
                      (context) => arg["play_audio_cubit"] as PlayAudioCubit,
                ),
              ],
              child: StoryAudios(),
            );
          },
        );
      case CreateStoryFirstStep.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => locator<StoryEditorCubit>()),
                BlocProvider(
                  create: (context) => locator<FeelingsActivitiesCubit>(),
                ),
                BlocProvider(create: (context) => locator<PostFriendsCubit>()),
                BlocProvider(create: (context) => locator<AddLocationCubit>()),
              ],
              child: CreateStoryFirstStep(),
            );
          },
        );
      case SelectMediaGalleryStory.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: arg["story_editor_cubit"] as StoryEditorCubit),
                BlocProvider.value(value: arg["post_friends_cubit"] as PostFriendsCubit),
                BlocProvider.value(value: arg["add_location_cubit"] as AddLocationCubit),
                BlocProvider.value(value: arg["feelings_activities_cubit"] as FeelingsActivitiesCubit),
                BlocProvider(create: (context) => locator<TextEditingCubit>()),
                BlocProvider(create: (context) => locator<DrawingStoryCubit>()),
                BlocProvider(
                  create: (context) => locator<CalculateTempCubit>(),
                ),
              ],
              child: SelectMediaGalleryStory(
                isMultiSelection: arg["isMultiSelection"],
              ),
            );
          },
        );
      case CameraCaptureScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: arg["story_editor_cubit"] as StoryEditorCubit),
                BlocProvider.value(value: arg["post_friends_cubit"] as FeelingsActivitiesCubit),
                BlocProvider.value(value: arg["add_location_cubit"] as AddLocationCubit),
                BlocProvider.value(value: arg["feelings_activities_cubit"] as FeelingsActivitiesCubit),
              ],
              child: CameraCaptureScreen(),
            );
          },
        );
      case StoryEditorScreen.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: arg["story_editor_cubit"] as StoryEditorCubit),
                BlocProvider.value(value: arg["post_friends_cubit"] as PostFriendsCubit),
                BlocProvider.value(value: arg["add_location_cubit"] as AddLocationCubit),
                BlocProvider.value(value: arg["feelings_activities_cubit"] as FeelingsActivitiesCubit),
                BlocProvider(create: (context) => locator<TextEditingCubit>()),
                BlocProvider(create: (context) => locator<DrawingStoryCubit>()),
                BlocProvider(
                  create: (context) => locator<CalculateTempCubit>(),
                ),
              ],
              child: StoryEditorScreen(),
            );
          },
        );
      case TextStoryEditor.routeName:
        final arg = routeSettings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: arg["story_editor_cubit"] as StoryEditorCubit),
                BlocProvider.value(value: arg["post_friends_cubit"] as PostFriendsCubit),
                BlocProvider.value(value: arg["add_location_cubit"] as AddLocationCubit),
                BlocProvider.value(value: arg["feelings_activities_cubit"] as FeelingsActivitiesCubit),
                BlocProvider(create: (context) => locator<TextEditingCubit>()),
                BlocProvider(create: (context) => locator<DrawingStoryCubit>()),
                BlocProvider(
                  create: (context) => locator<CalculateTempCubit>(),
                ),
              ],
              child: TextStoryEditor(),
            );
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
          (_) => Scaffold(
            appBar: AppBar(title: Text('no_route'.tr())),
            body: Center(child: Text('no_route'.tr())),
          ),
    );
  }
}

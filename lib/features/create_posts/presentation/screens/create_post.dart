import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/core/utils/helper/toast_utils.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/text_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/create_album_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/feelings_activities_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/places/all_user_places_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/post_vertical_option.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/ship_selection.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/text_editor_widget.dart';
import '../../../../core/utils/helper/snackbar.dart';
import 'edit_media/edit_media_screen.dart';
import 'horizental_post_option.dart';
import 'mention_friends.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  static const routeName = "Create_post";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<CreatePostCubit>()),
        BlocProvider(create: (context) => locator<PostFriendsCubit>()),
        BlocProvider(create: (context) => locator<FeelingsActivitiesCubit>()),
        BlocProvider(create: (context) => locator<AddLocationCubit>()),
        BlocProvider(create: (context) => EditMediaCubit([])),
      ],
      child: BlocListener<CreatePostCubit, CreatePostState>(
        listener: (context, state) {
          buildListener(context, state);
        },
        child: BlocBuilder<CreatePostCubit, CreatePostState>(
          builder: (context, state) {
            return Scaffold(
              appBar: getCustomAppBar(
                context: context,
                title: "create post",
                actions: [
                  Container(
                    height: 35,
                    margin: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: CustomElevatedButton(
                      label: "Create Post",
                      isLoading:
                          state.createPostStatus == CreatePostStatus.loading,
                      onPressed:
                          state.createPostStatus == CreatePostStatus.loading
                              ? () {}
                              : () =>
                                  context
                                      .read<CreatePostCubit>()
                                      .createRegularPost(),
                      backgroundColor: ColorManager.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.2,
                      isBold: true,
                    ),
                  ),
                ],
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 150),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                          vertical: AppPadding.p10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralImage.circular(
                                  image:
                                      context
                                          .read<AuthRepo>()
                                          .getUserInfo()
                                          ?.image,
                                  isNetworkImage: true,
                                  radius: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: ColorManager.primaryColor,
                                      width: 1.5,
                                    ),
                                  ),
                                  placeHolder: SvgPicture.asset(AssetsManager.user),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context.read<AuthRepo>().getName() ??
                                            "",
                                        style: AppTheme.headline4.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gaps.vGap1,
                                      Row(
                                        children: [
                                          ShipSelection(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                PostAudienceScreen.routeName,
                                                arguments: {
                                                  "create_post_cubit":
                                                      context
                                                          .read<
                                                            CreatePostCubit
                                                          >(),
                                                  "post_friends_cubit":
                                                      context
                                                          .read<
                                                            PostFriendsCubit
                                                          >(),
                                                },
                                              );
                                            },
                                            text: "Friends",
                                            svgAssets: AssetsManager.friendShip,
                                          ),
                                          ShipSelection(
                                            onTap:
                                                () => Navigator.pushNamed(
                                                  context,
                                                  MentionFriends.routeName,
                                                  arguments: {
                                                    "create_post_cubit":
                                                        context
                                                            .read<
                                                              CreatePostCubit
                                                            >(),
                                                    "post_friends_cubit":
                                                        context
                                                            .read<
                                                              PostFriendsCubit
                                                            >()..getFriendsList(),
                                                  },
                                                ),
                                            text: "Mentions",
                                            svgAssets:
                                                AssetsManager.postMention,
                                          ),
                                          _buildPostDisappear24Hours(context),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Gaps.vGap1,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ShipSelection(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      FeelingsActivitiesScreen.routeName,
                                      arguments: {
                                        "create_post_cubit":
                                            context.read<CreatePostCubit>(),
                                        "feelings_activities_cubit":
                                            context
                                                .read<
                                                  FeelingsActivitiesCubit
                                                >(),
                                      },
                                    );
                                  },
                                  text: "Feelings",
                                  svgAssets: AssetsManager.feelings,
                                ),
                                ShipSelection(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AllUserPlacesScreen.routeName,
                                      arguments: {
                                        "create_post_cubit":
                                            context.read<CreatePostCubit>(),
                                        "add_location_cubit":
                                            context.read<AddLocationCubit>(),
                                      },
                                    );
                                  },
                                  text: "Location",
                                  svgAssets: AssetsManager.location,
                                ),
                              ],
                            ),

                            Gaps.vGap3,
                            TextEditorWidget(
                              hint: 'what is in your mind?',
                              initialValue: state.regularPostEntity.content,
                              onChangedText: (String content) {
                                context.read<CreatePostCubit>().setPostText(
                                  content,
                                );
                                context
                                    .read<CreatePostCubit>()
                                    .toggleVerticalOption(false);
                              },
                              onChanged: (value) {
                                context.read<CreatePostCubit>().setPostTextBold(
                                  (value as TextPropertyEntity).isBold,
                                );
                                context
                                    .read<CreatePostCubit>()
                                    .setPostTextItalic(value.isItalic);
                                context
                                    .read<CreatePostCubit>()
                                    .setPostTextUnderLine(value.isUnderLine);
                                context.read<CreatePostCubit>().setTextColor(
                                  value.color,
                                );
                              },
                            ),
                            if (state
                                    .regularPostEntity
                                    .mediaFiles
                                    ?.isNotEmpty ??
                                false) ...[
                              Gaps.vGap2,
                              _buildMediaGallery(
                                context,
                                state.regularPostEntity.mediaFiles ?? [],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.showVerticalOption) ...[
                    PostVerticalOption(),
                  ] else ...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p50,
                          vertical: AppPadding.p8,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                              blurRadius: 6,
                              color: ColorManager.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: HorizontalPostOption(),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMediaGallery(BuildContext context, List<MediaEntity> assets) {
    int count = assets.length;
    if (count == 0) return const SizedBox.shrink();

    List<Widget> mediaWidgets = [];
    for (int i = 0; i < count; i++) {
      if (count > 5 && i == 4) {
        mediaWidgets.add(_buildStackedAsset(assets[i], count - 5, context));
        break;
      }
      mediaWidgets.add(_buildAssetItem(context, assets[i]));
    }

    Widget layout;

    if (count == 1) {
      layout = mediaWidgets[0];
    } else if (count == 2) {
      layout = Row(
        children: [
          Expanded(child: mediaWidgets[0]),
          SizedBox(width: 5),
          Expanded(child: mediaWidgets[1]),
        ],
      );
    } else if (count == 3) {
      layout = Column(
        children: [
          Row(
            children: [
              Expanded(child: mediaWidgets[0]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[1]),
            ],
          ),
          SizedBox(height: 5),
          mediaWidgets[2],
        ],
      );
    } else if (count == 4) {
      layout = Column(
        children: [
          Row(
            children: [
              Expanded(child: mediaWidgets[0]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[1]),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: mediaWidgets[2]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[3]),
            ],
          ),
        ],
      );
    } else {
      layout = Column(
        children: [
          Row(
            children: [
              Expanded(child: mediaWidgets[0]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[1]),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: mediaWidgets[2]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[3]),
              SizedBox(width: 5),
              Expanded(child: mediaWidgets[4]),
            ],
          ),
        ],
      );
    }

    return Stack(
      children: [
        layout,
        // 🔧 Edit & Rearrange icons
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              // Edit button
              _buildIconButton(
                assetName: AssetsManager.editPhotos,
                onTap:
                    () => {
                      Navigator.of(context).pushNamed(
                        EditMediaScreen.routeName,
                        arguments: {
                          "create_post_cubit": context.read<CreatePostCubit>(),
                          "initialIndex": 0,
                          "edit_media_cubit":
                              context.read<EditMediaCubit>()..updateMediaList(
                                context
                                        .read<CreatePostCubit>()
                                        .state
                                        .regularPostEntity
                                        .mediaFiles ??
                                    [],
                              ),
                        },
                      ),
                    },
              ),

              SizedBox(width: 8),

              // Rearrange button (only if more than 1)
              if (assets.length > 1)
                _buildIconButton(
                  assetName: AssetsManager.swap, // or Icons.reorder
                  onTap:
                      () => {
                        Navigator.of(context).pushNamed(
                          AlbumPhotosScreen.routeName,
                          arguments: {
                            "create_post_cubit":
                                context.read<CreatePostCubit>(),
                            "edit_media_cubit": context.read<EditMediaCubit>(),
                          },
                        ),
                      },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required String assetName,
    required VoidCallback onTap,
  }) {
    return GestureDetector(onTap: onTap, child: SvgPicture.asset(assetName));
  }

  Widget _buildAssetItem(BuildContext context, MediaEntity asset) {
    if (asset.isVideoFile) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FutureBuilder<Uint8List?>(
              future: context.read<EditMediaCubit>().generateVideoThumbnail(
                asset.file!,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data!);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          Icon(Icons.play_arrow, color: ColorManager.white),
        ],
      );
    } else {
      return Transform(
        alignment: Alignment.center,
        transform:
            Matrix4.identity()
              ..rotateZ((asset.rotateAngle ?? 0.0) * 3.1415926535 / 180)
              ..scale(
                (asset.isFlipHorizontal ?? false) ? -1.0 : 1.0,
                (asset.isFlipVertical ?? false) ? -1.0 : 1.0,
              ),
        child: Image.file(
          asset.file!,
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
      );
    }
  }

  Widget _buildStackedAsset(
    MediaEntity asset,
    int remainingCount,
    BuildContext context,
  ) {
    if (asset.isVideoFile) {
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FutureBuilder<Uint8List?>(
              future: context.read<EditMediaCubit>().generateVideoThumbnail(
                asset.file!,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(snapshot.data!);
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          Icon(Icons.play_arrow, color: ColorManager.white),
          Container(
            color: Colors.black45,
            alignment: Alignment.center,
            child: Text(
              '+$remainingCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return asset.file != null
          ? Stack(
            children: [
              Positioned.fill(
                child: Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.identity()
                        ..rotateZ(
                          (asset.rotateAngle ?? 0.0) * 3.1415926535 / 180,
                        )
                        ..scale(
                          (asset.isFlipHorizontal ?? false) ? -1.0 : 1.0,
                          (asset.isFlipVertical ?? false) ? -1.0 : 1.0,
                        ),
                  child: Image.file(asset.file!, fit: BoxFit.contain),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.black45,
                  alignment: Alignment.center,
                  child: Text(
                    '+$remainingCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
          : Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildPostDisappear24Hours(BuildContext context) {
    return InkWell(
      onTap: () => context.read<CreatePostCubit>().setPostAvailableFor24Hours(),
      child: SvgPicture.asset(
        context.read<CreatePostCubit>().state.regularPostEntity.disappears24h
            ? AssetsManager.postTimeActive
            : AssetsManager.postTime,
      ),
    );
  }

  void buildListener(BuildContext context, CreatePostState state) {
    if (state.createPostStatus == CreatePostStatus.success) {
      ToastUtils.showSusToastMessage("your post created successfully");
      Navigator.of(context).pop();
    } else if (state.createPostStatus == CreatePostStatus.offline ||
        state.createPostStatus == CreatePostStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/album_list_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/create_album_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/freinds_list.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/post_audience_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/video_player_screen.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/selected_video_thumbnail.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/ship_selection.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/ui/widgets/text_editor_widget.dart';
import '../../../location/presentation/screens/location_map_screen.dart';

class CreatePostText extends StatelessWidget {
  const CreatePostText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<CreatePostCubit>(),
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
                    label: "schedule",
                    onPressed: () {},
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
                                image: AssetsManager.manExample2,
                                isNetworkImage: false,
                                radius: 55,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorManager.primaryColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppPadding.p8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nour Alkhalil",
                                      style: AppTheme.headline4.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gaps.vGap1,

                                    Row(
                                      children: [
                                        ShipSelection(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) => BlocProvider.value(
                                                      value:
                                                          context
                                                              .read<
                                                                CreatePostCubit
                                                              >(),
                                                      child:
                                                          PostAudienceScreen(),
                                                    ),
                                              ),
                                            );
                                          },
                                          text: "Friends",
                                          svgAssets: AssetsManager.friendShip,
                                        ),
                                        ShipSelection(
                                          onTap:
                                              () => Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) => BlocProvider.value(
                                                        value:
                                                            context
                                                                .read<
                                                                  CreatePostCubit
                                                                >()
                                                              ..getAllFriends(),
                                                        child: FriendsList(
                                                          isMentionFriends:
                                                              true,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                          text: "Mentions",
                                          svgAssets: AssetsManager.postMention,
                                        ),
                                        ShipSelection(
                                          onTap: () {},
                                          text: "",
                                          svgAssets: AssetsManager.postTime,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Gaps.vGap1,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShipSelection(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AlbumGridScreen(),
                                    ),
                                  );
                                },
                                text: "Album",
                                svgAssets: AssetsManager.album,
                              ),
                              ShipSelection(
                                onTap: () {},
                                text: "Feelings",
                                svgAssets: AssetsManager.feelings,
                              ),
                              ShipSelection(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LocationMapScreen()));
                                },
                                text: "Location",
                                svgAssets: AssetsManager.location,
                              ),
                            ],
                          ),

                          Gaps.vGap3,
                          TextEditorWidget(
                            hint: 'what is in your mind?',
                            initialValue: "",
                            onChanged: (value) {
                              context.read<CreatePostCubit>().setPostText(
                                value,
                              );
                            },
                          ),
                          if (state.createPostEntity.images.isNotEmpty)
                            _buildImageGallery(
                              context,
                              state.createPostEntity.images,
                            ),
                          if (state.createPostEntity.assetEntity != null)
                            ...[
                              Gaps.vGap2,
                              SizedBox(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 0.25,
                                child: SelectedVideoItem(
                                  asset: state.createPostEntity.assetEntity!,
                                  onTap:
                                      () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => VideoPlayerScreen(
                                        video:
                                        state
                                            .createPostEntity
                                            .assetEntity!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.vGap2
                            ]
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.createPostEntity.text.isEmpty ||
                    state.createPostEntity.text == "<br> " ||
                    state.createPostEntity.images.isEmpty) ...[
                  DraggableScrollableSheet(
                    initialChildSize: 0.2,
                    minChildSize: 0.2,
                    maxChildSize: 0.5,
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: ColorManager.disActive.withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 5,
                              margin: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Expanded(
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  _buildOption(
                                    "Photo / Video",
                                    AssetsManager.photoPost,
                                    () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value:
                                                  context
                                                      .read<CreatePostCubit>(),
                                              child: CreateAlbumScreen(
                                                toCreateAlbum: false,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  _buildOption(
                                    "Shami post",
                                    AssetsManager.shamiPost,
                                    () {},
                                  ),
                                  _buildOption(
                                    "Live",
                                    AssetsManager.live,
                                    () {},
                                  ),
                                  _buildOption(
                                    "Camera",
                                    AssetsManager.cameraPost,
                                    () {},
                                  ),
                                  _buildOption(
                                    "Opinion poll",
                                    AssetsManager.opinionPoll,
                                    () {},
                                  ),
                                  _buildOption(
                                    "Personal occasion",
                                    AssetsManager.occasion,
                                    () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                      child: CustomElevatedButton(
                        label: "Done",
                        onPressed: () {},
                        backgroundColor: ColorManager.primaryColor,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOption(String label, String assetsName, Function() onTap) {
    return ListTile(
      leading: SvgPicture.asset(assetsName),
      title: Text(
        label,
        style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }

  Widget _buildImageGallery(BuildContext context, List<File> imageUrls) {
    int count = imageUrls.length;
    if (count == 0) return const SizedBox.shrink();

    List<Widget> images = [];
    for (int i = 0; i < count; i++) {
      if (count > 5 && i == 4) {
        // If we have more than 5 images, show the stack for the last image
        images.add(_buildStackedImage(imageUrls[i], count - 5, context, i));
        break;
      }
      images.add(_buildImageItem(context, imageUrls[i], i));
    }

    if (count == 1) {
      return images[0];
    } else if (count == 2) {
      return Row(
        children: [
          Expanded(child: images[0]),
          SizedBox(width: 5),
          Expanded(child: images[1]),
        ],
      );
    } else if (count == 3) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: images[0]),
              SizedBox(width: 5),
              Expanded(child: images[1]),
            ],
          ),
          SizedBox(height: 5),
          images[2],
        ],
      );
    } else if (count == 4) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: images[0]),
              SizedBox(width: 5),
              Expanded(child: images[1]),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: images[2]),
              SizedBox(width: 5),
              Expanded(child: images[3]),
            ],
          ),
        ],
      );
    } else if (count >= 5) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: images[0]),
              SizedBox(width: 5),
              Expanded(child: images[1]),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(child: images[2]),
              SizedBox(width: 5),
              Expanded(child: images[3]),
              SizedBox(width: 5),
              Expanded(child: images[4]),
            ],
          ),
        ],
      );
    }

    return Container();
  }

  Widget _buildStackedImage(
    File imageUrl,
    int remainingCount,
    BuildContext context,
    int index,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Expanded(
                child: GeneralImage.rectangle(
                  image: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  isNetworkImage: false,
                  // Set a fixed height for the image
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          color: Colors.black54,
          width: 25,
          height: 25,
          child: Text(
            "+$remainingCount",
            style: AppTheme.bodyText3.copyWith(
              color: ColorManager.primaryColor,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ],
    );
  }

  Widget _buildImageItem(BuildContext context, File imageUrl, int index) {
    return GestureDetector(
      onTap: () {},
      child: GeneralImage.rectangle(
        image: imageUrl,
        fit: BoxFit.cover,
        isNetworkImage: false,
        width: double.infinity,
        height: 300,
        // Set a fixed height for the images
      ),
    );
  }
}

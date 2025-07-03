import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:photofilters/widgets/photo_filter.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/crop_image_cubit/crop_image_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/rotate_photo_cubit/rotate_photo_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/edit_media/crop_image_options.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/edit_media/rotate_photo_screen.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:image/image.dart' as img;

import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/ui/widgets/custom_app_bar.dart';

class EditMediaScreen extends StatefulWidget {
  final int initialIndex;

  const EditMediaScreen({this.initialIndex = 0, super.key});

  static const routeName = "edit_media_screen";

  @override
  State<EditMediaScreen> createState() => _EditMediaScreenState();
}

class _EditMediaScreenState extends State<EditMediaScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  String? _activeTool;
  List<Filter> filters = presetFiltersList;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: getCustomAppBar(
            context: context,
            title: "Edit Photos/Videos",
          ),
          body: SafeArea(
            child: BlocBuilder<EditMediaCubit, EditMediaState>(
              builder: (context, state) {
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: state.mediaList.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                  _activeTool = null;
                                });
                              },
                              itemBuilder: (_, index) {
                                return BlocBuilder<
                                  EditMediaCubit,
                                  EditMediaState
                                >(
                                  builder: (context, state) {
                                    final media =
                                        state.mediaList[_currentIndex];
                                    if (media.isVideoFile) {
                                      return media.file == null
                                          ? Center(
                                            child: Container(
                                              width: 25,
                                              height: 25,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                          : Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Positioned.fill(
                                                child: FutureBuilder<
                                                  Uint8List?
                                                >(
                                                  future:
                                                      generateVideoThumbnail(
                                                        media.file!,
                                                      ),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      return Image.memory(
                                                        snapshot.data!,
                                                      );
                                                    }
                                                    return const CircularProgressIndicator();
                                                  },
                                                ),
                                              ),
                                              Icon(
                                                Icons.play_arrow,
                                                color: ColorManager.white,
                                              ),
                                            ],
                                          );
                                    } else {
                                      return media.file != null
                                          ? Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.identity()
                                                  ..rotateZ(
                                                    (state
                                                                .mediaList[_currentIndex]
                                                                .rotateAngle ??
                                                            0.0) *
                                                        3.1415926535 /
                                                        180,
                                                  )
                                                  ..scale(
                                                    (state
                                                                .mediaList[_currentIndex]
                                                                .isFlipHorizontal ??
                                                            false)
                                                        ? -1.0
                                                        : 1.0,
                                                    (state
                                                                .mediaList[_currentIndex]
                                                                .isFlipVertical ??
                                                            false)
                                                        ? -1.0
                                                        : 1.0,
                                                  ),
                                            child: Image.file(
                                              media.file!,
                                              fit: BoxFit.contain,
                                            ),
                                          )
                                          : Center(
                                            child: CircularProgressIndicator(),
                                          );
                                    }
                                  },
                                );
                              },
                            ),

                            // Left arrow
                            if (_currentIndex > 0)
                              Positioned(
                                left: 10,
                                child: InkWell(
                                  onTap:
                                      () => _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      ),
                                  child: SvgPicture.asset(
                                    AssetsManager.arrowBackFilled,
                                  ),
                                ),
                              ),

                            // Right arrow
                            if (_currentIndex <
                                context
                                        .read<CreatePostCubit>()
                                        .state
                                        .selectedMedia
                                        .length -
                                    1)
                              Positioned(
                                right: 10,
                                child: InkWell(
                                  onTap:
                                      () => _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      ),
                                  child: SvgPicture.asset(
                                    AssetsManager.arrowForwardFilled,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Gaps.vGap2,
                      // 🔧 Tools row
                      if(state.mediaList.isNotEmpty)...[
                        if (!state.mediaList[_currentIndex].isVideoFile)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _toolButton(
                                      AssetsManager.crop,
                                      'Crop',
                                      'crop',
                                          () {
                                        Navigator.of(context).pushNamed(
                                          CropScreen.routeName,
                                          arguments: {
                                            "edit_media_cubit":
                                            context.read<EditMediaCubit>(),
                                            "CropCubit": CropCubit(
                                              mediaEntity:
                                              state.mediaList[_currentIndex],
                                            ),
                                            "initialIndex": _currentIndex,
                                          },
                                        );
                                      },
                                      context,
                                    ),
                                    Gaps.hGap3,
                                    _toolButton(
                                      AssetsManager.rotate,
                                      'Rotate',
                                      'rotate',
                                          () async {
                                        Navigator.of(context).pushNamed(
                                          RotateImageScreen.routeName,
                                          arguments: {
                                            "edit_media_cubit":
                                            context.read<EditMediaCubit>(),
                                            "rotate_cubit": RotateMediaCubit(
                                              initialEntity:
                                              state.mediaList[_currentIndex],
                                            ),
                                            "initialIndex": _currentIndex,
                                          },
                                        );
                                      },
                                      context,
                                    ),
                                  ],
                                ),
                                Gaps.vGap2,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _toolButton(
                                      AssetsManager.effects,
                                      'Effects',
                                      'effects',
                                          () async {
                                        String fileName = basename(
                                          state
                                              .mediaList[_currentIndex]
                                              .file!
                                              .path,
                                        );
                                        var image = img.decodeImage(
                                          await state
                                              .mediaList[_currentIndex]
                                              .file!
                                              .readAsBytes(),
                                        );
                                        image = img.copyResize(
                                          image!,
                                          width: 600,
                                        );
                                        var imageFile = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PhotoFilterSelector(
                                              circleShape: false,
                                              title: const Text(
                                                "Photo Filter effects",
                                              ),
                                              image: image!,
                                              filters: presetFiltersList,
                                              filename: fileName!,
                                              appBarColor: ColorManager.white,
                                              loader: const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        );
                                        if (imageFile != null &&
                                            imageFile.containsKey(
                                              'image_filtered',
                                            )) {
                                          final updateEntity = state
                                              .mediaList[_currentIndex]
                                              .copyWith(
                                            file: imageFile['image_filtered'],
                                          );
                                          context
                                              .read<EditMediaCubit>()
                                              .updateMedia(
                                            _currentIndex,
                                            updateEntity,
                                          );
                                        }
                                      },
                                      context,
                                    ),
                                    Gaps.hGap3,
                                    _toolButton(
                                      AssetsManager.deleteImage,
                                      'Delete',
                                      'delete',
                                          () {
                                        if(state.mediaList.length==1){
                                          context
                                              .read<EditMediaCubit>()
                                              .deleteMedia(
                                            state.mediaList[_currentIndex],
                                          );
                                          context
                                              .read<CreatePostCubit>()
                                              .setFinalListOfMediaFiles(
                                            state.mediaList,
                                          );
                                        }else{
                                          context
                                              .read<EditMediaCubit>()
                                              .deleteMedia(
                                            state.mediaList[_currentIndex],
                                          );
                                        }

                                      },
                                      context,
                                      isDestructive: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        Gaps.vGap2,
                      ],


                      // Footer buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                label: "Done",
                                onPressed: () {
                                  context
                                      .read<CreatePostCubit>()
                                      .setFinalListOfMediaFiles(
                                        state.mediaList,
                                      );
                                  Navigator.of(context).pop();
                                },
                                backgroundColor: ColorManager.primaryColor,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomElevatedButton(
                                label: "Cancel",
                                onPressed: () => Navigator.of(context).pop(),
                                backgroundColor: ColorManager.white,
                                borderSide: BorderSide(
                                  color: ColorManager.gray600,
                                ),
                                foregroundColor: ColorManager.gray600,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _toolButton(
    String assetsName,
    String label,
    String toolKey,
    Function() callBack,
    BuildContext context, {
    bool isDestructive = false,
  }) {
    final isActive = _activeTool == toolKey;

    return CustomElevatedButton(
      svgAlignment: IconAlignment.start,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      label: label,
      onPressed: callBack,
      svgPic: SvgPicture.asset(assetsName),
      backgroundColor: ColorManager.white,
      borderSide: BorderSide(
        color: isDestructive ? ColorManager.red : ColorManager.gray600,
      ),
      foregroundColor: isDestructive ? ColorManager.red : ColorManager.gray600,
    );
  }

  Widget _cropOptions() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 10,
        children: [
          _optionChip('Square'),
          _optionChip('16:9'),
          _optionChip('Freeform'),
        ],
      ),
    );
  }

  // Widget _deleteConfirm() {
  //   return Padding(
  //     padding: const EdgeInsets.all(12),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text('Are you sure you want to delete this media?'),
  //         SizedBox(width: 10),
  //         TextButton(
  //           onPressed: () {
  //             // Handle deletion
  //             Navigator.pop(context);
  //           },
  //           child: Text('Yes', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _optionChip(String label) {
    return Chip(label: Text(label), backgroundColor: Colors.grey.shade200);
  }

  Future<Uint8List?> generateVideoThumbnail(File videoFile) async {
    final Uint8List? thumbnailBytes = await VideoThumbnail.thumbnailData(
      video: videoFile.path,
      imageFormat: ImageFormat.PNG,
      maxWidth: 600, // Adjust as needed
      quality: 75,
    );

    return thumbnailBytes;
  }
}

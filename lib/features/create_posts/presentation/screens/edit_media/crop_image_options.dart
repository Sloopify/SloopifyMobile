import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/crop_image_cubit/crop_image_state.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../blocs/crop_image_cubit/crop_image_cubit.dart';

class CropScreen extends StatefulWidget {
  final int index;

  const CropScreen({super.key, required this.index});
static const routeName ="crop_image_screen";
  @override
  State<CropScreen> createState() => _CropScreenState();
}


class _CropScreenState extends State<CropScreen> {
  Future<void> _cropWithAspectRatio(CropAspectRatio aspectRatio) async {
    final file = context.read<CropCubit>().state.mediaEntity.file;
    final cropped = await ImageCropper().cropImage(
      sourcePath: file!.path,
      aspectRatio: aspectRatio,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          backgroundColor: ColorManager.black,
          toolbarColor: Colors.black,
          toolbarWidgetColor: ColorManager.white,
          toolbarTitle: 'Crop',
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Crop', aspectRatioLockEnabled: true),
      ],
    );

    if (cropped != null) {
      final croppedImg = File(cropped.path);
      context.read<CropCubit>().setCroppedImage(croppedImg);
    }
  }

  Future<void> _openCustomCrop() async {
    final file = context.read<CropCubit>().state.mediaEntity.file;
    final cropped = await ImageCropper().cropImage(
      sourcePath: file!.path,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Custom Crop',
          backgroundColor: ColorManager.black,
          toolbarColor: Colors.black,
          toolbarWidgetColor: ColorManager.white,
        ),
        IOSUiSettings(title: 'Custom Crop'),
      ],
    );

    if (cropped != null) {
      final croppedImg = File(cropped.path);
      context.read<CropCubit>().setCroppedImage(croppedImg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Crop your photo"),
      body: SafeArea(
        child:
            context.read<CropCubit>().state.mediaEntity.file == null
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BlocBuilder<CropCubit, CropState>(
                              builder: (context, state) {
                                return Image.file(
                                  context
                                      .read<CropCubit>()
                                      .state
                                      .mediaEntity
                                      .file!,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                            Gaps.vGap1,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p50,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildCropOption(
                                      assets: AssetsManager.square,
                                      label: "Square",
                                      onTap: () {
                                        _cropWithAspectRatio(
                                          const CropAspectRatio(
                                            ratioX: 1,
                                            ratioY: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Gaps.hGap2,
                                  Expanded(
                                    child: _buildCropOption(
                                      assets: AssetsManager.rectangular,
                                      label: "Rectangular",
                                      onTap: () {
                                        _cropWithAspectRatio(
                                          const CropAspectRatio(
                                            ratioX: 4,
                                            ratioY: 3,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.vGap2,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p50,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildCropOption(
                                      assets: AssetsManager.towThree,
                                      label: "2:3",
                                      onTap: () {
                                        _cropWithAspectRatio(
                                          const CropAspectRatio(
                                            ratioX: 2,
                                            ratioY: 3,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Gaps.hGap2,
                                  Expanded(
                                    child: _buildCropOption(
                                      assets: AssetsManager.sixteenNine,
                                      label: "16:9",
                                      onTap: () {
                                        _cropWithAspectRatio(
                                          const CropAspectRatio(
                                            ratioX: 16,
                                            ratioY: 9,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gaps.vGap2,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppPadding.p50,
                              ),
                              child: _buildCropOption(
                                assets: AssetsManager.customCrop,
                                label: "Custom Crop",
                                onTap: _openCustomCrop,
                              ),
                            ),
                            Gaps.vGap10,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                        ),
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                              color: ColorManager.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                foregroundColor: ColorManager.white,
                                padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                ),
                                backgroundColor: ColorManager.primaryColor,
                                width: MediaQuery.of(context).size.width * 0.4,
                                label: "Done",
                                onPressed: () {
                                  context.read<EditMediaCubit>().updateMedia(
                                    widget.index,
                                    context.read<CropCubit>().state.mediaEntity,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                            Gaps.hGap3,
                            Expanded(
                              child: CustomElevatedButton(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppPadding.p8,
                                ),
                                backgroundColor: ColorManager.white,
                                borderSide: BorderSide(
                                  color: ColorManager.gray600,
                                ),
                                foregroundColor: ColorManager.gray600,
                                width: MediaQuery.of(context).size.width * 0.4,
                                label: "Cancel",
                                onPressed: () {
                                  context.read<CropCubit>().resetOriginalFile();
                                  context.read<EditMediaCubit>().updateMedia(
                                    widget.index,
                                    context.read<CropCubit>().state.mediaEntity,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildCropOption({
    required String assets,
    required String label,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              offset: Offset(0, 2),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.gray600),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assets),
            Gaps.hGap1,
            Text(
              label,
              style: AppTheme.headline4.copyWith(color: ColorManager.gray600),
            ),
          ],
        ),
      ),
    );
  }
}

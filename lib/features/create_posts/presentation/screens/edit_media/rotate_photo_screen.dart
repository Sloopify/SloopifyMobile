import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../domain/entities/media_entity.dart';
import '../../blocs/rotate_photo_cubit/rotate_photo_cubit.dart';
import '../../blocs/rotate_photo_cubit/rotate_photo_state.dart';

class RotateImageScreen extends StatelessWidget {
  final int index;

  const RotateImageScreen({
    super.key,
    required this.index,
  });
static const routeName ="rotate_image";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Rotate photo"),
      body: BlocBuilder<RotateMediaCubit, RotateMediaState>(
        builder: (context, state) {
          final image = FileImage(state.mediaEntity.file!);
          final angle = state.mediaEntity.rotateAngle ?? 0.0;
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20, vertical: AppPadding.p10),
            child: Column(
              children: [
                Expanded(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateZ(angle * 3.1415926535 / 180)
                      ..scale(
                          (state.mediaEntity.isFlipHorizontal ?? false)
                              ? -1.0
                              : 1.0,
                          (state.mediaEntity.isFlipVertical ?? false)
                              ? -1.0
                              : 1.0
                      ),
                    child: Image(image: image, height: 150, fit: BoxFit
                        .cover,),
                  ),
                ),
                Gaps.vGap3,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      foregroundColor: ColorManager.gray600,
                      backgroundColor: ColorManager.white,
                      borderSide: BorderSide(color: ColorManager.gray600),
                      width: MediaQuery.of(context).size.width*0.4,
                      label: "flip horizontal",
                      onPressed: () =>context.read<RotateMediaCubit>().flipHorizontal(),
                      svgPic: SvgPicture.asset(AssetsManager.flipHorizontal),
                      svgAlignment: IconAlignment.start,
                    ),
                    CustomElevatedButton(
                      foregroundColor: ColorManager.gray600,
                      backgroundColor: ColorManager.white,
                      borderSide: BorderSide(color: ColorManager.gray600),
                      width: MediaQuery.of(context).size.width*0.4,
                      label: "flip vertical",
                      onPressed: () =>context.read<RotateMediaCubit>().flipVertical(),
                      svgPic: SvgPicture.asset(AssetsManager.flipVertical),
                      svgAlignment: IconAlignment.start,
                    ),

                  ],
                ),
                Gaps.vGap2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(
                      foregroundColor: ColorManager.gray600,
                      backgroundColor: ColorManager.white,
                      borderSide: BorderSide(color: ColorManager.gray600),
                      width: MediaQuery.of(context).size.width*0.2,
                      label: "90ْ ",
                      onPressed: () =>context.read<RotateMediaCubit>().rotateLeft(),
                      svgPic: SvgPicture.asset(AssetsManager.rotateLeft),
                      svgAlignment: IconAlignment.start,
                    ),
                    CustomElevatedButton(
                      foregroundColor: ColorManager.gray600,
                      backgroundColor: ColorManager.white,
                      borderSide: BorderSide(color: ColorManager.gray600),
                      width: MediaQuery.of(context).size.width*0.2,
                      label: "90ْ ",
                      onPressed: () =>context.read<RotateMediaCubit>().rotateRight(),
                      svgPic: SvgPicture.asset(AssetsManager.rotateRight),
                      svgAlignment: IconAlignment.start,
                    ),
                  ],
                ),
                Gaps.vGap3,

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          foregroundColor: ColorManager.white,
                          padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                          backgroundColor: ColorManager.primaryColor,
                          width: MediaQuery.of(context).size.width*0.4,
                          label: "Done",
                          onPressed: () {
                            context.read<EditMediaCubit>().updateMedia(index, state.mediaEntity);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Gaps.hGap3,
                      Expanded(
                        child: CustomElevatedButton(
                          padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                          backgroundColor: ColorManager.white,
                          borderSide: BorderSide(color: ColorManager.gray600),
                          foregroundColor: ColorManager.gray600,
                          width: MediaQuery.of(context).size.width*0.4,
                          label: "Cancel",
                          onPressed: () {
                            context.read<RotateMediaCubit>().reset();
                            context.read<EditMediaCubit>().updateMedia(index, state.mediaEntity);
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_state.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/assets_managers.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/utils/helper/image_picker.dart';

class AccountPhotosHeader extends StatelessWidget {
  const AccountPhotosHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPictureCubit, UploadPictureState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                state.coverImage == null
                    ? Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: ColorManager.backGroundGray.withOpacity(0.25),
                      ),
                    )
                    : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: FileImage(state.coverImage!),
                        ),
                      ),
                    ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(color: ColorManager.white),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:
                  state.image != null
                      ? CircleAvatar(
                        backgroundImage: FileImage(state.image!),
                        radius: 55,
                      )
                      : Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorManager.backGroundGrayLight,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsetsDirectional.all(AppPadding.p20),
                        child: SvgPicture.asset(AssetsManager.user),
                      ),
            ),
            PositionedDirectional(
              start: MediaQuery.of(context).size.width * 0.58,
              child: InkWell(
                onTap: () async {
                  ImageSource imageSource = await showPickerImageSheet(context);
                  File? pickedImage = await pickImage(context, imageSource);
                  if (pickedImage != null) {
                    context.read<UploadPictureCubit>().setPicture(pickedImage);
                  }
                },
                child: SvgPicture.asset(AssetsManager.edit),
              ),
            ),
            PositionedDirectional(
              bottom: 20,
              end: 20,
              child: InkWell(
                onTap: () async {
                  ImageSource imageSource = await showPickerImageSheet(context);
                  File? pickedImage = await pickImage(context, imageSource);
                  if (pickedImage != null) {
                    context.read<UploadPictureCubit>().setCoverPicture(
                      pickedImage,
                    );
                  }
                },
                child: SvgPicture.asset(AssetsManager.edit),
              ),
            ),
          ],
        );
      },
    );
  }
}

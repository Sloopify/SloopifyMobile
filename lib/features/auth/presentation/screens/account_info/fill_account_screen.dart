import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_state.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/referred_day.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/assets_managers.dart';
import '../../../../../core/managers/color_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/helper/image_picker.dart';
import '../../../../../core/utils/helper/snackbar.dart';

class FillAccountScreen extends StatelessWidget {
  FillAccountScreen({super.key});

  static const routeName = "fill_account";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        withArrowBack: false,
        context: context,
        title: "fill_your_account".tr(),
        centerTitle: true,
      ),
      body: BlocConsumer<UploadPictureCubit, UploadPictureState>(
        listener: (context, state) {
          _buildSubmitListener(context, state);
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.image != null
                      ? Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(state.image!),
                            radius: 150,
                          ),
                          PositionedDirectional(
                            bottom: 8,
                            start: 210,
                            child: InkWell(
                              onTap: () async {
                                ImageSource imageSource =
                                    await showPickerImageSheet(context);
                                File? pickedImage = await pickImage(
                                  context,
                                  imageSource,
                                );
                                if (pickedImage != null) {
                                  context.read<UploadPictureCubit>().setPicture(
                                    pickedImage,
                                  );
                                }
                              },
                              child: SvgPicture.asset(AssetsManager.edit),
                            ),
                          ),
                        ],
                      )
                      : Stack(
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorManager.backGroundGrayLight,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsetsDirectional.all(AppPadding.p20),
                            child: SvgPicture.asset(AssetsManager.user),
                          ),

                          PositionedDirectional(
                            bottom: 12,
                            start: 200,
                            child: InkWell(
                              onTap: () async {
                                ImageSource imageSource =
                                    await showPickerImageSheet(context);
                                File? pickedImage = await pickImage(
                                  context,
                                  imageSource,
                                );
                                if (pickedImage != null) {
                                  context.read<UploadPictureCubit>().setPicture(
                                    pickedImage,
                                  );
                                }
                              },
                              child: SvgPicture.asset(AssetsManager.edit),
                            ),
                          ),
                        ],
                      ),
                  Gaps.vGap5,
                  Center(
                    child: CustomElevatedButton(
                      isLoading:
                          state.uploadPictureStatus ==
                          UploadPictureStatus.loading,
                      isBold: true,
                      label: "continue".tr(),
                      onPressed: () {
                        if (state.image == null) {
                          showSnackBar(context, 'you should choose an image.',isImportant: true);
                        } else {
                          if (state.uploadPictureStatus ==
                              UploadPictureStatus.loading) {
                            return;
                          } else {
                            context.read<UploadPictureCubit>().submit();
                          }
                        }
                      },
                      backgroundColor: ColorManager.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.75,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _buildSubmitListener(BuildContext context, UploadPictureState state) {
    if (state.uploadPictureStatus == UploadPictureStatus.done) {
      Navigator.of(context).pushNamed(ReferredDay.routeName);
    } else if (state.uploadPictureStatus == UploadPictureStatus.noInternet) {
      showSnackBar(context, "no_internet_connection".tr(),isOffline: true);
    } else if (state.uploadPictureStatus == UploadPictureStatus.networkError) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }
}

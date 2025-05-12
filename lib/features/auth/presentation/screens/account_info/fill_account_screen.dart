import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/core/utils/app_validators.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/account_info/profile_info_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/upload_photo_cubit/upload_photo_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/referred_day.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/account_photos_header.dart';

class FillAccountScreen extends StatelessWidget {
   FillAccountScreen({super.key});

  static const routeName = "fill_account";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<UploadPictureCubit>(),
      child: Scaffold(
        appBar: getCustomAppBar(context: context, title: "fill_your_account".tr(),centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AccountPhotosHeader(),
                Gaps.vGap3,
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "bio2".tr(),
                              withTitle: true,
                              labelText: "bio".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setBio(value);
                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "education2".tr(),
                              withTitle: true,
                              labelText: "education".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setEducation(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "job2".tr(),
                              withTitle: true,
                              labelText: "job".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setJobs(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "experience2".tr(),
                              withTitle: true,
                              labelText: "experience".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setEducation(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "skills2".tr(),
                              withTitle: true,
                              labelText: "Skills".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setSkills(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "links2".tr(),
                              withTitle: true,
                              labelText: "links".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setLinks(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap1,
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              hintText: "location2".tr(),
                              withTitle: true,
                              labelText: "location".tr(),
                              onChanged: (value) {
                                context.read<ProfileInfoCubit>().setLocation(value);

                              },
                              validator:
                                  (value) =>
                                      Validator.requiredValidate(value!, context),
                            ),
                            Gaps.vGap3,
                            CustomElevatedButton(isBold: true,
                              label: "continue".tr(),
                              onPressed: () {
                              if(!(_formKey.currentState!.validate())) return;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: context.read<ProfileInfoCubit>(),
                                      child: ReferredDay(),
                                    );
                                  },
                                ),
                              );
                              },
                              backgroundColor: ColorManager.primaryColor,
                              width: MediaQuery.of(context).size.width * 0.75,
                            ),
                            Gaps.vGap3,

                          ],
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/gender_identity_cubit/gender_identity_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/birthday_screen.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/gender_item.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/managers/theme_manager.dart';

class GenderIdentity extends StatelessWidget {
  const GenderIdentity({super.key});

  static const routeName = "gender_identity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        onArrowBack: (){
          if(Navigator.of(context).canPop()){
            Navigator.of(context).pop(());
          }else{
            SystemNavigator.pop();
          }
        },
        context: context,
        title: "tell_us_gender".tr(),
        centerTitle: true,
      ),
      body: BlocListener<GenderIdentityCubit, CompleteGenderState>(
        listener: (context, state) {
          _buildSubmitListener(context, state);
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p30,
                vertical: AppPadding.p10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "tell_us_gender_hint".tr(),
                    style: AppTheme.headline4.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gaps.vGap3,
                  BlocBuilder<GenderIdentityCubit, CompleteGenderState>(
                    builder: (context, state) {
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GenderItem(
                              gender: Gender.male,
                              selectedGender: state.gender,
                              onSelect: () {
                                context.read<GenderIdentityCubit>().setGender(
                                  Gender.male,
                                );
                              },
                            ),
                            Gaps.vGap3,
                            GenderItem(
                              gender: Gender.female,
                              selectedGender: state.gender,
                              onSelect: () {
                                context.read<GenderIdentityCubit>().setGender(
                                  Gender.female,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Gaps.vGap5,
                  Center(
                    child: CustomElevatedButton(
                      isLoading:
                          context
                              .read<GenderIdentityCubit>()
                              .state
                              .completeGenderStatus ==
                          CompleteGenderStatus.loading,
                      isBold: true,
                      label: "continue".tr(),
                      onPressed: () {
                        if (context.read<GenderIdentityCubit>().state.gender ==
                            Gender.none) {
                          showSnackBar(
                            context,
                            'you should select your interest',
                          );
                        } else {
                          if (context
                                  .read<GenderIdentityCubit>()
                                  .state
                                  .completeGenderStatus ==
                              CompleteGenderStatus.loading) {
                            return;
                          } else {
                            context.read<GenderIdentityCubit>().submitGender();
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
          ),
        ),
      ),
    );
  }

  void _buildSubmitListener(BuildContext context, CompleteGenderState state) {
    if (state.completeGenderStatus == CompleteGenderStatus.success) {
      Navigator.of(context).pushNamed(BirthdayScreen.routeName);
    } else if (state.completeGenderStatus == CompleteGenderStatus.offline) {
      showSnackBar(context, "no_internet_connection".tr());
    } else if (state.completeGenderStatus == CompleteGenderStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}

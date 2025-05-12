import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/account_info/profile_info_cubit.dart';
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
      appBar: getCustomAppBar(context: context, title: "tell_us_gender".tr(),centerTitle: true),
      body: SafeArea(
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
                BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                  builder: (context, state) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GenderItem(
                            gender: Gender.male,
                            selectedGender: state.userProfileEntity.gender,
                            onSelect: () {
                              context.read<ProfileInfoCubit>().setGender(
                                Gender.male,
                              );
                            },
                          ),
                          Gaps.vGap3,
                          GenderItem(
                            gender: Gender.female,
                            selectedGender: state.userProfileEntity.gender,
                            onSelect: () {
                              context.read<ProfileInfoCubit>().setGender(
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
                    isBold: true,
                    label: "continue".tr(),
                    onPressed: () {
                      if (context
                          .read<ProfileInfoCubit>()
                          .state
                          .userProfileEntity
                          .gender==Gender.none) {
                        showSnackBar(
                          context,
                          'you should select your interest',
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return BlocProvider.value(
                                value: context.read<ProfileInfoCubit>(),
                                child: BirthdayScreen(),
                              );
                            },
                          ),
                        );
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
    );
  }
}

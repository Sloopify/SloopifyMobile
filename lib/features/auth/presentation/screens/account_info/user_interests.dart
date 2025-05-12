import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/account_info/profile_info_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/gender_identity.dart';

class UserInterests extends StatelessWidget {
  const UserInterests({super.key});

  static const routeName = "user_interests_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<ProfileInfoCubit>()..getAllInterests(),
      child: Scaffold(
        appBar: getCustomAppBar(
          centerTitle: true,
          context: context,
          title: "choose_interests".tr(),
        ),
        body: Builder(
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p30,
                  vertical: AppPadding.p10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "choose_interests_hint".tr(),
                        style: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gaps.vGap3,
                      BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                        builder: (context, state) {
                          return GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.interests.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 3,
                                ),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomElevatedButton(
                                borderSide: BorderSide(
                                  color: ColorManager.primaryColor,
                                  width: 2,
                                ),
                                backgroundColor:
                                    state.interests[index] ==
                                            state.userProfileEntity.interest
                                        ? ColorManager.primaryColor
                                        : ColorManager.white,
                                label: state.interests[index],
                                onPressed: () {
                                  context.read<ProfileInfoCubit>().setInterest(
                                    state.interests[index],
                                  );
                                },
                                foregroundColor:
                                    state.interests[index] ==
                                            state.userProfileEntity.interest
                                        ? ColorManager.white
                                        : ColorManager.primaryColor,
                              );
                            },
                          );
                        },
                      ),
                      Gaps.vGap3,
                      Center(
                        child: CustomElevatedButton(
                          isBold: true,
                          label: "continue".tr(),
                          onPressed: () {
                            if (context
                                .read<ProfileInfoCubit>()
                                .state
                                .userProfileEntity
                                .interest
                                .isEmpty) {
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
                                      child: GenderIdentity(),
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
            );
          }
        ),
      ),
    );
  }
}

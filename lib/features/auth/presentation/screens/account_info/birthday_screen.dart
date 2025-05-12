import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/date_formatter.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/account_info/profile_info_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/fill_account_screen.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/helper/snackbar.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});
static const routeName="Birth_day";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: 'what_is_birthday'.tr(),centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            print(state.userProfileEntity.birthDay);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p30,
                  vertical: AppPadding.p10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "birthday_hint".tr(),
                      style: AppTheme.headline4.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gaps.vGap3,
                    Center(child: SvgPicture.asset(AssetsManager.birthday)),
                    Gaps.vGap3,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p10,
                        vertical: AppPadding.p8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: ColorManager.black,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                           DateFormatter.getFormatedDate(state.userProfileEntity.birthDay),
                            style: AppTheme.headline4.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: ColorManager.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    DatePickerWidget(
                      looping: false,
                      initialDate: state.userProfileEntity.birthDay,
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      dateFormat: "dd MMMM yyyy",
                      onChange: (date, _) {
                        context.read<ProfileInfoCubit>().setBirthDay(date);
                      },
                      pickerTheme: DateTimePickerTheme(
                        backgroundColor: Colors.white,
                        itemTextStyle: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        dividerColor: Colors.transparent,
                      ),
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
                              .userProfileEntity.birthDay==DateTime.now()) {
                            showSnackBar(
                              context,
                              'you should select a valid birthday',
                            );

                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: context.read<ProfileInfoCubit>(),
                                    child: FillAccountScreen(),
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
            );
          },
        ),
      ),
    );
  }
}

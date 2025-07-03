import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/date_formatter.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/complete_birthday_cubit/complete_birthday_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/complete_birthday_cubit/complete_birthday_state.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/fill_account_screen.dart';

import '../../../../../core/managers/app_dimentions.dart';
import '../../../../../core/managers/theme_manager.dart';
import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/helper/snackbar.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  static const routeName = "Birth_day";

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
        title: 'what_is_birthday'.tr(),
        centerTitle: true,
        withArrowBack: false,
      ),
      body: SafeArea(
        child: BlocListener<CompleteBirthdayCubit, CompleteBirthdayState>(
          listener: (context, state) {
            _buildSubmitListener(context, state);
          },
          child: BlocBuilder<CompleteBirthdayCubit, CompleteBirthdayState>(
            builder: (context, state) {
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
                          border: Border.all(
                            color: ColorManager.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.birthday != null
                                  ? DateFormatter.getFormatedDate(
                                    state.birthday!,
                                  )
                                  : "DD/M/YYYYY",
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
                        initialDate: state.birthday,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        dateFormat: "dd MMMM yyyy",
                        onChange: (date, _) {
                          context.read<CompleteBirthdayCubit>().setBirthDay(
                            date,
                          );
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
                          isLoading:
                              state.completeBirthDayStatus ==
                              CompleteBirthDayStatus.loading,
                          isBold: true,
                          label: "continue".tr(),
                          onPressed: () {
                            if (state.birthday == DateTime.now() ||
                                state.birthday == null) {
                              showSnackBar(
                                isWarning: true,
                                context,
                                'you should select a valid birthday',
                              );
                            }else if ( DateTime.now().difference(state.birthday!).inDays<(13*365)){
                              showSnackBar(
                                isError: true,
                                context,
                                'Sorry, you must older than 13 years old',
                              );
                            } else {
                              if (state.completeBirthDayStatus ==
                                  CompleteBirthDayStatus.loading) {
                                return;
                              } else {
                                context
                                    .read<CompleteBirthdayCubit>()
                                    .submitBirthDay();
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
        ),
      ),
    );
  }

  void _buildSubmitListener(BuildContext context, CompleteBirthdayState state) {
    if (state.completeBirthDayStatus == CompleteBirthDayStatus.success) {
      Navigator.of(context).pushNamed(FillAccountScreen.routeName);
    } else if (state.completeBirthDayStatus == CompleteBirthDayStatus.offline) {
      showSnackBar(context, "no_internet_connection".tr());
    } else if (state.completeBirthDayStatus == CompleteBirthDayStatus.error) {
      showSnackBar(context, state.errorMessage);
    }
  }
}

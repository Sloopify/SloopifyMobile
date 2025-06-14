import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../blocs/create_post_cubit/create_post_cubit.dart';

class ActivitiesByCategories extends StatelessWidget {
  final String name;

  const ActivitiesByCategories({super.key, required this.name});

  static const routeName = "activities_by_categories";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: name),
      body: SafeArea(
        child: BlocBuilder<FeelingsActivitiesCubit, FeelingsActivitiesState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
                vertical: AppPadding.p10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Search for activities",
                          withTitle: false,
                          onChanged: (value) {
                            context
                                .read<FeelingsActivitiesCubit>()
                                .setSearchActivityName(value);
                          },
                        ),
                      ),
                      Gaps.hGap2,
                      SizedBox(
                        width: 70,
                        height: 50,
                        child: CustomElevatedButton(
                          label: "Find",
                          onPressed: () {
                            context
                                .read<FeelingsActivitiesCubit>()
                                .searchActivityByCategoryName();
                          },
                          backgroundColor: ColorManager.primaryColor
                              .withOpacity(0.3),
                          borderSide: BorderSide(
                            color: ColorManager.primaryColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state.getActivityStatus == GetActivityStatus.loading) ...[
                    Center(child: CircularProgressIndicator()),
                  ] else if (state.getActivityStatus ==
                          GetActivityStatus.offline ||
                      state.getActivityStatus == GetActivityStatus.error) ...[
                    Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap:
                                () {
                                  context
                                    .read<FeelingsActivitiesCubit>()
                                    .selectActivityName(
                                      state.activities[index].name,
                                    );
                                  context.read<CreatePostCubit>().setActivityName(
                                      state.selectedActivity);
                                },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GeneralImage.rectangle(
                                  image: state.activities[index].mobileIcon,
                                  isNetworkImage: true,
                                  width: 50,
                                  height: 50,
                                ),
                                Gaps.hGap1,
                                Text(
                                  state.activities[index].name,
                                  style: AppTheme.headline4.copyWith(
                                    color:
                                        state.activities[index].name ==
                                                state.selectedActivity
                                            ? ColorManager.primaryColor
                                            : ColorManager.gray600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Gaps.vGap2;
                        },
                        itemCount: state.activities.length,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

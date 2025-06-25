import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_footer.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';

import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../blocs/create_post_cubit/create_post_cubit.dart';
import '../screens/activities_by_categories.dart';

class CategoriesActivitiesWidget extends StatefulWidget {
  const CategoriesActivitiesWidget({super.key});

  @override
  State<CategoriesActivitiesWidget> createState() =>
      _CategoriesActivitiesWidgetState();
}

class _CategoriesActivitiesWidgetState
    extends State<CategoriesActivitiesWidget> {
  @override
  void initState() {
    context.read<FeelingsActivitiesCubit>().getAllCategoriesActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeelingsActivitiesCubit, FeelingsActivitiesState>(
      builder: (context, state) {
        return Column(
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
                          .setSearchCategoryName(value);
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
                          .searchCategoriesActivitiesByNameCategory();
                    },
                    backgroundColor: ColorManager.primaryColor.withOpacity(
                      0.3,
                    ),
                    borderSide: BorderSide(
                      color: ColorManager.primaryColor.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
            if (state.getCategoriesActivityStatus ==
                GetCategoriesActivityStatus.loading &&state.categoriesActivity.isEmpty) ...[
              Center(child: Padding(
                padding:  EdgeInsets.only(top: AppPadding.p20),
                child: CircularProgressIndicator(),
              )),
            ] else if (state.getCategoriesActivityStatus ==
                GetCategoriesActivityStatus.offline) ...[
              Center(
                child: Text(
                  "no internet connection",
                  style: AppTheme.headline4.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ]else if (state.getCategoriesActivityStatus ==
                GetCategoriesActivityStatus.error) ...[
              Center(
                child: Text(
                state.errorMessage,
                  style: AppTheme.headline4.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
            ] else...[
              Expanded(
                child: SmartRefresher(
                  controller:
                  context
                      .read<FeelingsActivitiesCubit>()
                      .categoriesRefreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  onRefresh:
                      () =>
                      context
                          .read<FeelingsActivitiesCubit>()
                          .onRefreshCategories(),
                  onLoading:
                      () =>
                      context
                          .read<FeelingsActivitiesCubit>()
                          .onLoadMoreCategories(),
                  footer: customFooter,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildCategoriesGridItem(
                        context,
                        state.categoriesActivity[index],
                        state.categoriesActivity[index] ==
                            state.selectedCategoryName,
                      );
                    },
                    itemCount: state.categoriesActivity.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                color: ColorManager.white,
                child: CustomElevatedButton(
                  label: "Done",
                  onPressed: () => Navigator.of(context).pop(),
                  width: MediaQuery.of(context).size.width * 0.7,
                  borderSide: BorderSide(
                    color: ColorManager.primaryColor.withOpacity(0.3),
                  ),
                  backgroundColor: ColorManager.primaryColor.withOpacity(0.3),
                ),
              ),
            ]
          ],
        );
      },
    );
  }

  Widget _buildCategoriesGridItem(
    BuildContext context,
    String categoryName,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () {
        context.read<FeelingsActivitiesCubit>().selectCategoryName(
          categoryName,
        );
        Navigator.of(context).pushNamed(
          ActivitiesByCategories.routeName,
          arguments: {
            "categoryName": categoryName,
            "create_post_cubit": context.read<CreatePostCubit>(),
            "feelings_activities_cubit":
                context.read<FeelingsActivitiesCubit>()
                  ..getActivityByCategoryName(),
          },
        );
      },
      child: BlocBuilder<FeelingsActivitiesCubit, FeelingsActivitiesState>(
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color:
                    isSelected
                        ? ColorManager.primaryColor
                        : ColorManager.gray600,
              ),
            ),
            child: Text(
              categoryName,
              style: AppTheme.headline4.copyWith(
                fontWeight: FontWeight.w600,
                color:
                    isSelected
                        ? ColorManager.primaryColor
                        : ColorManager.gray600,
              ),
            ),
          );
        },
      ),
    );
  }
}

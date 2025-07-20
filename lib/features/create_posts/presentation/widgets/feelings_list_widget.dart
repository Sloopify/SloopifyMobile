import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_footer.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/feeling_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';

import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';

class FeelingsListWidget extends StatefulWidget {
  const FeelingsListWidget({super.key});

  @override
  State<FeelingsListWidget> createState() => _FeelingsListWidgetState();
}

class _FeelingsListWidgetState extends State<FeelingsListWidget> {
  @override
  void initState() {
    context.read<FeelingsActivitiesCubit>().getFeelings();
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
                    hintText: "Serach for a friend",
                    withTitle: false,
                    onChanged: (value) {
                      context
                          .read<FeelingsActivitiesCubit>()
                          .setFeelingName(
                        value,
                      );
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
                          .searchFeelings();
                    },
                    backgroundColor: ColorManager.primaryColor.withOpacity(
                        0.3),
                    borderSide: BorderSide(
                      color: ColorManager.primaryColor.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
            if(state.getFeelingStatus == GetFeelingStatus.loading && state.allFeelings.isEmpty)...[
              Center(child: Padding(
                padding:  EdgeInsets.only(top: AppPadding.p20),
                child: CircularProgressIndicator(),
              ),),
            ] else
              if(state.getFeelingStatus == GetFeelingStatus.offline)...[
                Center(child: Text("no internet connection",
                  style: AppTheme.headline4.copyWith(
                      color: ColorManager.black),),),
              ] else
                if(state.getFeelingStatus == GetFeelingStatus.error)...[
                  Center(child: Text(state.errorMessage,
                    style: AppTheme.headline4.copyWith(
                        color: ColorManager.black),),),
                ] else...[
                  Expanded(
                    child: SmartRefresher(
                      controller:
                      context
                          .read<FeelingsActivitiesCubit>()
                          .feelingRefreshController,
                      enablePullUp: true,
                      enablePullDown: true,
                      onRefresh:
                          () =>
                          context
                              .read<FeelingsActivitiesCubit>()
                              .onRefreshFeelings(),
                      onLoading:
                          () =>
                          context
                              .read<FeelingsActivitiesCubit>()
                              .onLoadMoreFeelings(),
                      footer: customFooter,
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildfeelingGridItem(
                            context,
                            state.allFeelings[index],
                            state.allFeelings[index].name == state
                                .selectedFeeling,
                          );
                        },
                        itemCount: state.allFeelings.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
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
                      onPressed: () {
                        context.read<CreatePostCubit>().setFeelingName(
                            state.selectedFeeling);
                        Navigator.of(context).pop();
                      },
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

  Widget _buildfeelingGridItem(BuildContext context,
      FeelingEntity feeling,
      bool isSelected,) {
    return InkWell(
      onTap:
          () {
        if(context.read<FeelingsActivitiesCubit>().state.selectedFeeling==feeling.name){
          context.read<FeelingsActivitiesCubit>().selectFeelings("");
        }else{
          context.read<FeelingsActivitiesCubit>().selectFeelings(
            feeling.name,
          );
        }

          },
      child: BlocBuilder<FeelingsActivitiesCubit, FeelingsActivitiesState>(
          builder: (context, state) {
            print(state.selectedFeeling);
            return Container(
              padding: EdgeInsets.all(AppPadding.p8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color:
                  isSelected ? ColorManager.primaryColor : ColorManager.gray600,
                ),
              ),
              child: Row(
                children: [
                  GeneralImage.circular(
                    radius: 25,
                    isNetworkImage: true,
                    image: feeling.mobileIcon,
                  ),
                  Gaps.hGap1,
                  Text(
                    feeling.name,
                    style: AppTheme.headline4.copyWith(
                      fontWeight: FontWeight.w600,
                      color:
                      isSelected
                          ? ColorManager.primaryColor
                          : ColorManager.gray600,
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}

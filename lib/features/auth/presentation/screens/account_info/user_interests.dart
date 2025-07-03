import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/user_interets_cubit/user_interests_cubit.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/user_interets_cubit/user_interests_state.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/account_info/gender_identity.dart';
import 'package:sloopify_mobile/features/auth/presentation/widgets/account_info/interests_grid_item.dart';

import '../../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../widgets/account_info/loading_categories_shimmer.dart';

class UserInterests extends StatefulWidget {
  static const routeName = "UserInterests";

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  final ScrollController scrollController = ScrollController();

  void _onArrowPressed(bool forward) {
    final cubit = context.read<InterestCubit>();
    int currentIndex = cubit.state.currentCategoryIndex;
    int nextIndex = currentIndex + (forward ? 1 : -1);
    if (nextIndex >= 0 && nextIndex < cubit.state.categoriesName.length) {
      _pageController.animateToPage(
        nextIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      cubit.selectCategory(nextIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InterestCubit, InterestState>(
      listener: (context, state) {
        _buildSubmitListener(context, state);
      },
      child: BlocBuilder<InterestCubit, InterestState>(
        builder: (context, state) {
          final cubit = context.read<InterestCubit>();
          return Scaffold(
            appBar: getCustomAppBar(
              context: context,
              title: "",
              onArrowBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop(());
                } else {
                  SystemNavigator.pop();
                }
              },
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                          vertical: AppPadding.p10,
                        ),
                        child: Text(
                          "Choose your interests and get the best recommendations",
                          style: AppTheme.headline3.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (state.getCategoriesStatus ==
                              GetCategoriesStatus.loading &&
                          state.categoriesName.isEmpty)
                        Center(child: LoadingCategoriesShimmer()),
                      if (state.categoriesName.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                _onArrowPressed(false);
                              },
                            ),
                            Expanded(
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      color: ColorManager.black.withOpacity(
                                        0.1,
                                      ),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                    ),
                                    BoxShadow(
                                      offset: Offset(0, -2),
                                      color: ColorManager.black.withOpacity(
                                        0.1,
                                      ),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: PageView.builder(
                                  controller: _pageController,
                                  itemCount: state.categoriesName.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  // disable manual scroll
                                  itemBuilder: (context, index) {
                                    final isSelected =
                                        index == state.currentCategoryIndex;
                                    final category =
                                        state.categoriesName[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: AppPadding.p8,
                                        ),
                                        decoration:
                                            isSelected
                                                ? BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 4,
                                                      offset: Offset(0, 1),
                                                      spreadRadius: 0,
                                                      color: ColorManager.black
                                                          .withOpacity(0.25),
                                                    ),
                                                  ],
                                                  color: ColorManager.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                )
                                                : null,
                                        child: Center(
                                          child: Text(
                                            category,
                                            style: AppTheme.headline4.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  isSelected
                                                      ? ColorManager
                                                          .primaryColor
                                                      : ColorManager
                                                          .primaryColor
                                                          .withOpacity(0.35),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                _onArrowPressed(true);
                              },
                            ),
                          ],
                        ),
                      if (state.categoriesInterests.isEmpty &&
                          state.getCategoriesInterestsStatus ==
                              GetCategoriesInterestsStatus.loading)
                        Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else
                        Expanded(
                          child: SmartRefresher(
                            controller:
                                context.read<InterestCubit>().refreshController,
                            enablePullUp: true,
                            enablePullDown: true,
                            onRefresh:
                                () => context.read<InterestCubit>().onRefresh(),
                            onLoading:
                                () =>
                                    context.read<InterestCubit>().onLoadMore(),
                            footer: CustomFooter(height: 100,
                              loadStyle: LoadStyle.ShowAlways,
                              builder: (context, mode) {
                                if (mode == LoadStatus.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (mode == LoadStatus.noMore) {
                                  return  SizedBox.shrink();
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                            child: GridView.builder(
                              padding:  EdgeInsets.only(left: AppPadding.p16,right: AppPadding.p16,top: AppPadding.p16,bottom: AppPadding.p50),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                              itemCount: state.categoriesInterests.length,
                              itemBuilder: (context, index) {
                                final interest =
                                    state.categoriesInterests[index];
                                return GestureDetector(
                                  onTap:
                                      () => cubit.toggleInterest(interest.id),
                                  child: InterestsGridItem(
                                    userInterestsEntity: interest,
                                    isSelected: state.selectedInterestIds
                                        .contains(interest.id),
                                  ),
                                ); // your widget
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      width: double.infinity,
                      height: 60,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p50,
                        vertical: AppPadding.p8,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 6,
                            color: ColorManager.black.withOpacity(0.25),
                          ),
                        ],
                      ),
                      child: CustomElevatedButton(
                        isLoading:
                            state.completeInterestsStatus ==
                            CompleteInterestsStatus.loading,
                        onPressed:
                            state.completeInterestsStatus ==
                                    CompleteInterestsStatus.loading
                                ? () {}
                                : () {
                                  cubit.submitInterests();
                                },
                        label: "continue",
                        backgroundColor: ColorManager.primaryColor,
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
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

  void _buildSubmitListener(BuildContext context, InterestState state) {
    if (state.completeInterestsStatus == CompleteInterestsStatus.success) {
      Navigator.of(context).pushNamed(GenderIdentity.routeName);
    } else if (state.completeInterestsStatus ==
        CompleteInterestsStatus.offline) {
      showSnackBar(context, "no_internet_connection".tr(),isOffline: true);
    } else if (state.completeInterestsStatus == CompleteInterestsStatus.error) {
      showSnackBar(context, state.errorMessage,isError: true);
    }
  }
}

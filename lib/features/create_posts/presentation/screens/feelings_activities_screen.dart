import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';
import '../widgets/categories_activity_widget.dart';
import '../widgets/feelings_list_widget.dart';

class FeelingsActivitiesScreen extends StatefulWidget {
  const FeelingsActivitiesScreen({super.key});

  static const routeName = "Feelings_activities";

  @override
  State<FeelingsActivitiesScreen> createState() =>
      _FeelingsActivitiesScreenState();
}

class _FeelingsActivitiesScreenState extends State<FeelingsActivitiesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  int _selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _isSelected(int index) {
    // Determine if the tab should be selected based on the current index
    return _selectedIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "How are you feeling ?"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p10,
          ),
          child: BlocBuilder<FeelingsActivitiesCubit, FeelingsActivitiesState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTabBar(),
                  Gaps.vGap2,
                  Expanded(
                    child: TabBarView(physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [FeelingsListWidget(), CategoriesActivitiesWidget()],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 40,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: ColorManager.white),
      child: TabBar(
        onTap: (index) {
          _onTabSelected(index);
        },
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        isScrollable: true,
        dividerColor: ColorManager.disActive,
        labelPadding: EdgeInsets.symmetric(horizontal: 50),
        labelColor: ColorManager.primaryColor,
        unselectedLabelColor: ColorManager.disActive,
        labelStyle: AppTheme.headline3.copyWith(
          color: ColorManager.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: AppTheme.headline3.copyWith(
          color: ColorManager.disActive,
          fontWeight: FontWeight.bold,
        ),
        indicatorColor: ColorManager.primaryColor,
        tabAlignment: TabAlignment.center,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.zero,
        tabs: [_buildFeelingTab(), _buildActivityTab()],
      ),
    );
  }

  Widget _buildFeelingTab() {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsManager.feelings,
          color: _isSelected(0) ? null : ColorManager.disActive,
        ),
        Gaps.hGap1,

        Text("feelings"),
      ],
    );
  }

  Widget _buildActivityTab() {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsManager.activities,
          color: _isSelected(1) ? ColorManager.primaryColor : null,
        ),
        Gaps.hGap1,
        Text("Activities"),
      ],
    );
  }
}

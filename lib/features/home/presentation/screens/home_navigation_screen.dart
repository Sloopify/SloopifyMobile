import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/home/presentation/blocs/home_navigation_cubit/home_navigation_state.dart';
import 'package:sloopify_mobile/features/home/presentation/screens/ai_system_screen.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/home_screen.dart';
import 'package:sloopify_mobile/features/home/presentation/widgets/app_dawer.dart';
import '../blocs/home_navigation_cubit/home_navigation_cubit.dart';
import '../widgets/ai_system_widgets/header_ai_system.dart';

class HomeNavigationScreen extends StatelessWidget {
  static const routeName = "home_navigation_screen";
  final List<Widget> pages = const [
    HomeScreen(),
    Center(child: Text("will be implemented soon ")),
    Center(child: Text("will be implemented soon ")),
    Center(child: Text("will be implemented soon ")),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<HomeNavigationCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: ColorManager.white,
            drawer: CustomDrawer(),
            body: SafeArea(
              child: BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
                builder:
                    (context, state) =>
                    Stack(
                      children: [
                        pages[state.selectedIndex],
                        if (state.isFabPanelOpen)
                          Positioned.fill(
                            child: Container(
                              color: ColorManager.white,
                              child: AiSystemScreen(),
                            ),
                          ),
                      ],
                    ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              onTap: () {
                context.read<HomeNavigationCubit>().toggleFabPanel();
              },
              child: Transform.rotate(
                angle: 0.78539,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: ColorManager.primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Transform.rotate(
                      angle: -0.78539,
                      child: SvgPicture.asset(AssetsManager.robot),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorManager.bottomNavigationBackGround.withOpacity(0.6),
              height: 65,
              shape: RoundedDiamondNotchedShape(),
              notchMargin: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavIcon(context, AssetsManager.home, 0, 'Home'),
                    _buildNavIcon(context, AssetsManager.group, 1, "Group"),
                    SizedBox(width: 50), // FAB space
                    _buildNavIcon(context, AssetsManager.market, 2, "Market"),
                    _buildNavIcon(context, AssetsManager.videoPlayer, 3, "Video"),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildNavIcon(BuildContext context,
      String assetName,
      int index,
      String text,) {
    final selectedIndex =
        context
            .watch<HomeNavigationCubit>()
            .state
            .selectedIndex;
    return selectedIndex != index
        ? InkWell(
      child: SvgPicture.asset(assetName),
      onTap: () {
        context.read<HomeNavigationCubit>().navigateTo(index);
      },
    )
        : InkWell(
      onTap: () {
        context.read<HomeNavigationCubit>().navigateTo(index);
      },
      child: Container(
        width: 90,
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetName, color: ColorManager.primaryColor),
            Text(
              text,
              style: AppTheme.bodyText3.copyWith(
                color: ColorManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Post")),
      body: Center(child: Text("Post creation screen")),
    );
  }
}

class RoundedDiamondNotchedShape extends NotchedShape {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    const double notchRadius = 44.0;
    const double cornerRadius = 4.0;
    const double barCornerRadius = 20.0; // top-left and top-right bar corner

    if (guest == null || !guest.overlaps(host)) {
      return Path()
        ..moveTo(host.left + barCornerRadius, host.top)
        ..quadraticBezierTo(
          host.left,
          host.top,
          host.left,
          host.top + barCornerRadius,
        )
        ..lineTo(host.left, host.bottom)..lineTo(
            host.right, host.bottom)..lineTo(
            host.right, host.top + barCornerRadius)
        ..quadraticBezierTo(
          host.right,
          host.top,
          host.right - barCornerRadius,
          host.top,
        )
        ..lineTo(host.left + barCornerRadius, host.top)
        ..close();
    }

    final notchCenter = guest.center;
    final topLeft = Offset(notchCenter.dx - notchRadius, host.top);
    final bottom = Offset(notchCenter.dx, guest.bottom);
    final topRight = Offset(notchCenter.dx + notchRadius, host.top);

    final path = Path();

    // Start with rounded top-left corner of bar
    path.moveTo(host.left + barCornerRadius, host.top);
    path.quadraticBezierTo(
      host.left,
      host.top,
      host.left,
      host.top + barCornerRadius,
    );
    path.lineTo(host.left, host.bottom);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.right, host.top + barCornerRadius);
    path.quadraticBezierTo(
      host.right,
      host.top,
      host.right - barCornerRadius,
      host.top,
    );

    // Go to notch
    path.lineTo(topRight.dx + cornerRadius, topRight.dy);
    path.quadraticBezierTo(
      topRight.dx,
      topRight.dy,
      topRight.dx - cornerRadius,
      topRight.dy + cornerRadius,
    );
    path.lineTo(bottom.dx + cornerRadius, bottom.dy - cornerRadius);
    path.quadraticBezierTo(
      bottom.dx,
      bottom.dy,
      bottom.dx - cornerRadius,
      bottom.dy - cornerRadius,
    );
    path.lineTo(topLeft.dx + cornerRadius, topLeft.dy + cornerRadius);
    path.quadraticBezierTo(
      topLeft.dx,
      topLeft.dy,
      topLeft.dx - cornerRadius,
      topLeft.dy,
    );

    path.lineTo(host.left + barCornerRadius, host.top);
    path.close();

    return path;
  }
}

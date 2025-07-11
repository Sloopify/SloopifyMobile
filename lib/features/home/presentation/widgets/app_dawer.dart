import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/suggestedFriendListPage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.159,
                decoration: BoxDecoration(
                  color: ColorManager.deepPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.364,
                decoration: BoxDecoration(color: Colors.white),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.159,
                decoration: BoxDecoration(
                  color: ColorManager.primaryShade1,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.159,
                decoration: BoxDecoration(
                  color: ColorManager.primaryShade2,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.159,
                decoration: BoxDecoration(color: ColorManager.primaryShade3),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 30,
            child: Container(
              padding: EdgeInsets.only(
                left: AppPadding.p10,
                right: AppPadding.p10,
                top: AppPadding.p50,
                bottom: AppPadding.p35,
              ),
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(AssetsManager.backGroundDrawer),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: ColorManager.black.withOpacity(0.25),
                  ),
                  BoxShadow(
                    offset: Offset(0, -10),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: ColorManager.black.withOpacity(0.25),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(AssetsManager.logo, width: 50, height: 25),
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorManager.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap3,
                  drawerItem(
                    itemName: "Nour Alkhalil",
                    isPersonalAccount: true,
                    onTap: () {},
                  ),
                  Gaps.vGap2,
                  drawerItem(
                    itemName: "Personal account",
                    assets: AssetsManager.personalAccount,
                    onTap: () {},
                  ),
                  Gaps.vGap2,

                  drawerItem(
                    itemName: "Friendship",
                    assets: AssetsManager.friendShip,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SuggestedFriendListPage(),
                        ),
                      );
                    },
                  ),
                  Gaps.vGap2,

                  drawerItem(
                    itemName: "Statistics",
                    assets: AssetsManager.chart,
                    onTap: () {},
                  ),
                  Gaps.vGap2,

                  drawerItem(
                    itemName: "My diary",
                    assets: AssetsManager.diary,
                    onTap: () {},
                  ),
                  Gaps.vGap2,

                  drawerItem(
                    itemName: "Settings",
                    assets: AssetsManager.settings,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem({
    String? assets,
    required String itemName,
    bool isPersonalAccount = false,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p10,
        ),
        child: Row(
          children: [
            if (isPersonalAccount) ...[
              GeneralImage.circular(
                radius: 50,
                image: AssetsManager.manExample2,
                isNetworkImage: false,
              ),
            ] else ...[
              SvgPicture.asset(assets!),
            ],
            Gaps.hGap3,
            Text(
              itemName,
              style: AppTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorManager.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 25; // Less pronounced than 40

    // Top curve
    Offset topControlPoint = Offset(size.width / 2, -curveHeight);
    Offset topEndPoint = Offset(size.width, curveHeight);

    // Bottom curve
    Offset bottomControlPoint = Offset(
      size.width / 2,
      size.height + curveHeight,
    );
    Offset bottomEndPoint = Offset(0, size.height - curveHeight);

    Path path =
        Path()
          ..moveTo(0, curveHeight)
          ..quadraticBezierTo(
            topControlPoint.dx,
            topControlPoint.dy,
            topEndPoint.dx,
            topEndPoint.dy,
          )
          ..lineTo(size.width, size.height - curveHeight)
          ..quadraticBezierTo(
            bottomControlPoint.dx,
            bottomControlPoint.dy,
            bottomEndPoint.dx,
            bottomEndPoint.dy,
          )
          ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

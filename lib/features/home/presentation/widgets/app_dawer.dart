import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.primaryShade1,
      elevation: 0,
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
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
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
                decoration: BoxDecoration(
                  color: ColorManager.primaryShade3,
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 70,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(400,100),bottom: Radius.elliptical(400,100)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: ColorManager.bottomNavigationBackGround
                  ),
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: ColorManager.black.withOpacity(0.25)
                  ),

                  BoxShadow(
                      offset: Offset(0, -2),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: ColorManager.bottomNavigationBackGround
                  ),
                  BoxShadow(
                      offset: Offset(0, -10),
                      blurRadius: 10,
                      spreadRadius: 0,
                      color: ColorManager.black.withOpacity(0.25)
                  ),


                ],
                color: ColorManager.white,
              ),
              height: MediaQuery.of(context).size.height * 0.511, // Not full height
              child: Column(
                children: [
                  SizedBox(height: 60),

                  SizedBox(height: 10),
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  drawerItem(Icons.person, "Personal account"),
                  drawerItem(Icons.group, "Friendship"),
                  drawerItem(Icons.bar_chart, "Statistics"),
                  drawerItem(Icons.book, "My diary"),
                  drawerItem(Icons.settings, "Settings"),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Powered by SpinerLoop\nV 1.0.0",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87),
          SizedBox(width: 12),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        ],
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
    Offset bottomControlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset bottomEndPoint = Offset(0, size.height - curveHeight);

    Path path = Path()
      ..moveTo(0, curveHeight)
      ..quadraticBezierTo(topControlPoint.dx, topControlPoint.dy, topEndPoint.dx, topEndPoint.dy)
      ..lineTo(size.width, size.height - curveHeight)
      ..quadraticBezierTo(bottomControlPoint.dx, bottomControlPoint.dy, bottomEndPoint.dx, bottomEndPoint.dy)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
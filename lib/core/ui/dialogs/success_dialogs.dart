import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';


class SuccessDialogs extends StatelessWidget {
  const SuccessDialogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.7,
      padding: EdgeInsets.all(AppPadding.p10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset(
              AssetsManager.success,
              repeat: true,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

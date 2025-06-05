import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/shimmer_widget.dart';

class LoadingCategoriesShimmer extends StatelessWidget {
  const LoadingCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget.rectangular(
      color: Colors.grey.shade100,
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

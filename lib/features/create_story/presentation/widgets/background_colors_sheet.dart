import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/text_editor_widget.dart';

class BackgroundColorsSheet extends StatelessWidget {
  BackgroundColorsSheet({super.key});

  final List<GradientBackground> gradients = [
    GradientBackground(ColorManager.pink, ColorManager.blueGradiant),
    GradientBackground(Colors.white, Colors.white),
    GradientBackground(
      ColorManager.primaryColor.withOpacity(0.2),
      Colors.white,
    ),
    GradientBackground(Colors.purple, Colors.white),
    GradientBackground(Colors.pink, Colors.purple),
    GradientBackground(Colors.blue, Colors.blue),
    GradientBackground(Colors.pink, Colors.black12),
    GradientBackground(Colors.green, Colors.green),
    GradientBackground(Colors.pink, Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "backgrounds",
              style: AppTheme.headline3.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorManager.black,
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: ColorManager.disActive.withOpacity(0.4),
          ),
          Gaps.vGap2,
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            children:
                gradients
                    .map(
                      (gradient) => GestureDetector(
                        onTap: () {
                          context.read<StoryEditorCubit>().setBackGroundGradiant(gradient);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [gradient.startColor, gradient.endColor],
                            ),

                            border: Border.all(color: Colors.black26),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}

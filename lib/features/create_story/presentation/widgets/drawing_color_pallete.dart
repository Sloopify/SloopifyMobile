import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';

import '../blocs/drawing_story/drawing_story_cubit.dart';

class DrawingColorPallete extends StatelessWidget {
  const DrawingColorPallete({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 50,
      left: 50,
      right: 0,
      child: Center(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
            [
              ColorManager.primaryColor,
              ColorManager.offWhite,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.orange,
              Colors.pink,
              Colors.white,
              Colors.black,
            ]
                .map(
                  (color) => GestureDetector(
                onTap:
                    () => context
                    .read<DrawingStoryCubit>()
                    .changeDrawingColor(color),
                child: Container(
                  width: 25,
                  height: 25,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                      context
                          .read<DrawingStoryCubit>()
                          .state
                          .lineColor ==
                          color
                          ? Colors.white
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}

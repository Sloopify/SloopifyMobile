import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../create_story/presentation/screens/create_Story_first_step.dart';

class HomeStories extends StatelessWidget {
  const HomeStories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              GeneralImage.circular(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primaryColor,
                    width: 1.5,
                  ),
                ),
                radius: 70,
                isNetworkImage: false,
                image: AssetsManager.homeExample3,
                fit: BoxFit.cover,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) =>
                          BlocProvider(
                            create: (context) => StoryEditorCubit(),
                            child: CreateStoryFirstStep(),
                          )));
                },
                child: SvgPicture.asset(AssetsManager.addStory),
              ),
            ],
          ),
          Gaps.hGap1,
          Container(width: 1.5, height: 70, color: ColorManager.black),
          Gaps.hGap1,

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GeneralImage.circular(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.black.withOpacity(0.25),
                          blurRadius: 4,
                          offset: Offset(4, 0),
                          spreadRadius: 0
                      )
                    ],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.primaryColor,
                      width: 2,
                    ),
                  ),
                  radius: 70,
                  isNetworkImage: false,
                  image: AssetsManager.manExample,
                  fit: BoxFit.cover,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Gaps.hGap2;
              },
            ),
          ),
        ],
      ),
    );
  }
}

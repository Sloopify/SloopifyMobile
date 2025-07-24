import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';

class PostStoryBtn extends StatelessWidget {
  const PostStoryBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: BlocBuilder<StoryEditorCubit, StoryEditorState>(
        builder: (context, state) {
          return CustomElevatedButton(
            isLoading: state.createStoryStatus==CreateStoryStatus.loading,
            width: MediaQuery.of(context).size.width * 0.22,
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p8,
              vertical: 0,
            ),
            label: "Post",
            onPressed: state.createStoryStatus==CreateStoryStatus.loading?(){}:() {
              context.read<StoryEditorCubit>().createStory();
            },
            backgroundColor: ColorManager.primaryColor,
          );
        },
      ),
    );
  }
}

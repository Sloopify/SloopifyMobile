import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/core/ui/widgets/general_image.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/audio_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/play_audio_cubit/play_audio_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/widgets/selected_audio_player.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../../../../core/ui/widgets/custom_elevated_button.dart';
import '../../../../core/ui/widgets/custom_footer.dart';
import '../../../../core/ui/widgets/custom_text_field.dart';

class StoryAudios extends StatefulWidget {
  const StoryAudios({super.key});

  static const routeName = "story_audios_list";

  @override
  State<StoryAudios> createState() => _StoryAudiosState();
}

class _StoryAudiosState extends State<StoryAudios> {
  @override
  void initState() {
    context.read<PlayAudioCubit>().getAllAudios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "choose your audio",
        withArrowBack: true,
      ),
      body: SafeArea(
        child: BlocBuilder<PlayAudioCubit, PlayAudioState>(
          builder: (context, state) {
            print(state.selectedAudioUrl);
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p20,
                vertical: AppPadding.p10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "Search for audio",
                          withTitle: false,
                          onChanged: (value) {
                            context.read<PlayAudioCubit>().setSearchKeyWord(
                              value,
                            );
                          },
                        ),
                      ),
                      Gaps.hGap2,
                      SizedBox(
                        width: 70,
                        height: 50,
                        child: CustomElevatedButton(
                          label: "Find",
                          onPressed: () {
                            context.read<PlayAudioCubit>().searchAudios();
                          },
                          backgroundColor: ColorManager.primaryColor
                              .withOpacity(0.3),
                          borderSide: BorderSide(
                            color: ColorManager.primaryColor.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.vGap3,
                  if (state.getAudioStatus == GetAudioStatus.loading &&
                      state.audioFiles.isEmpty) ...[
                    Padding(
                      padding: EdgeInsets.only(top: AppPadding.p20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ] else if (state.getAudioStatus ==
                      GetAudioStatus.offline) ...[
                    Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTheme.headline4,
                      ),
                    ),
                  ] else if (state.getAudioStatus == GetAudioStatus.error) ...[
                    Center(
                      child: Text(
                        state.errorMessage,
                        style: AppTheme.headline4,
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: SmartRefresher(
                        controller:
                            context.read<PlayAudioCubit>().refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        onRefresh:
                            () => context.read<PlayAudioCubit>().onRefresh(),
                        onLoading:
                            () => context.read<PlayAudioCubit>().onLoadMore(),
                        footer: customFooter,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemCount: state.audioFiles.length,
                          itemBuilder: (context, index) {
                            return _buildAudioItem(
                              state.audioFiles[index],
                              context,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Gaps.vGap2;
                          },
                        ),
                      ),
                    ),
                    if (state.selectedAudioUrl.isNotEmpty)
                      SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: AudioPlayerWidget(
                              voice: state.selectedAudioUrl,
                              audioName: state.selectedAudioName,
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAudioItem(AudioEntity audio, BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<PlayAudioCubit>().setAudioId(audio.id);
        context.read<PlayAudioCubit>().setAudioImage(audio.image);
        context.read<PlayAudioCubit>().setAudioUrl(audio.fileUrl);
        context.read<PlayAudioCubit>().setAudioName(audio.name);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralImage.circular(
            image: audio.image,
            isNetworkImage: true,
            radius: 30,
          ),
          Gaps.hGap1,
          Text(
            audio.name,
            style: AppTheme.headline4.copyWith(color: ColorManager.black),
          ),
        ],
      ),
    );
  }
}

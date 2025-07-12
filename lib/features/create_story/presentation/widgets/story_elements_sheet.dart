import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/utils/helper/api_keys.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/widgets/feelings_list_widget.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/play_audio_cubit/play_audio_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_state.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_feelings_list.dart';

import '../../../../core/locator/service_locator.dart';
import '../../../../core/managers/app_gaps.dart' show Gaps;
import '../../../create_posts/presentation/blocs/add_location_cubit/add_location_cubit.dart';
import '../../../create_posts/presentation/screens/places/all_user_places_screen.dart';
import '../screens/story_audios.dart';

class StoryElementsSheet extends StatefulWidget {
  const StoryElementsSheet({super.key});

  @override
  State<StoryElementsSheet> createState() => _StoryElementsSheetState();
}

class _StoryElementsSheetState extends State<StoryElementsSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryEditorCubit, StoryEditorState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p10,
            vertical: AppPadding.p10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Location',
                    asset: AssetsManager.storyLocation,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AllUserPlacesScreen.routeName,
                        arguments: {
                          "story_editor_cubit":
                              context.read<StoryEditorCubit>(),
                          "add_location_cubit":
                              context.read<AddLocationCubit>()..setFromStory(),
                          "fromStory": true,
                        },
                      );
                    },
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Poll',
                    asset: AssetsManager.storyPoll,
                    onTap: () {},
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Mention',
                    asset: AssetsManager.storyMention,
                    onTap: () {
                      context.read<StoryEditorCubit>().addMentionElement(
                        friendId: 1,
                        friendName: 'Nour Alkhalil',
                      );
                    },
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Audio',
                    asset: AssetsManager.storyAudio,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StoryAudios.routeName,
                        arguments: {
                          "story_editor_cubit":
                              context.read<StoryEditorCubit>(),
                          "play_audio_cubit": locator<PlayAudioCubit>(),
                        },
                      );
                    },
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Clock',
                    asset: AssetsManager.storyClock,
                    onTap: () {},
                  ),
                  BlocBuilder<CalculateTempCubit, CalculateTempState>(
                    builder: (context, state) {
                      if (state.temperatureElement != null) {
                        return _buildElementOption(
                          context: context,
                          text:
                              '${state.temperatureElement!.value}${state.weatherCode}',
                          asset: AssetsManager.storyWeather,
                          onTap: () {
                            context
                                .read<StoryEditorCubit>()
                                .addTemperatureElement(
                                  state.temperatureElement!,
                                );
                          },
                        );
                      } else
                        return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              Gaps.vGap1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildElementOption(
                    context: context,
                    text: 'Feeling',
                    asset: AssetsManager.storyFeeling,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StoryFeelingsList.routeName,
                        arguments: {
                          "story_editor_cubit":
                              context.read<StoryEditorCubit>(),
                          "feelings_activities_cubit":
                              context.read<FeelingsActivitiesCubit>()
                                ..setFromStory(),
                        },
                      );
                    },
                  ),
                  _buildElementOption(
                    context: context,
                    text: 'Gif',
                    asset: AssetsManager.storyGif,
                    onTap: () {
                      pickGif(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildElementOption({
    required String text,
    required String asset,
    required Function() onTap,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.lightGray),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: ColorManager.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(asset),
            Gaps.hGap1,
            Text(
              text,
              style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickGif(BuildContext context) async {
    final GiphyGif? gif = await GiphyGet.getGif(
      context: context,
      apiKey: ApiKeys.giphyAndroidApiKey,
      lang: GiphyLanguage.english,
      searchText: 'Search for a GIF',
      tabColor: Colors.purpleAccent,
      modal: true,
    );

    if (gif != null) {
      final gifUrl = gif.images?.original?.url;
      if (gifUrl != null) {
        context.read<StoryEditorCubit>().addStickerElement(gifUrl: gifUrl);
      }
    }
  }
}

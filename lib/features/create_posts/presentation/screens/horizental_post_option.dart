import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/places/all_user_places_screen.dart';

import '../blocs/add_location_cubit/add_location_cubit.dart';
import '../blocs/create_post_cubit/create_post_cubit.dart';
import '../blocs/edit_media_cubit/edit_media_cubit.dart';
import '../blocs/feeling_activities_post_cubit/feelings_activities_cubit.dart';
import '../blocs/post_friends_cubit/post_freinds_cubit.dart';
import 'create_album_screen.dart';
import 'feelings_activities_screen.dart';
import 'mention_friends.dart';

class HorizontalPostOption extends StatelessWidget {
  const HorizontalPostOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOption(
          AssetsManager.photoPost,
          () => Navigator.of(context).pushNamed(
            AlbumPhotosScreen.routeName,
            arguments: {
              "create_post_cubit": context.read<CreatePostCubit>(),
              "edit_media_cubit": context.read<EditMediaCubit>(),
            },
          ),
        ),
        _buildOption(
          AssetsManager.postMention,
          () => Navigator.pushNamed(
            context,
            MentionFriends.routeName,
            arguments: {
              "create_post_cubit": context.read<CreatePostCubit>(),
              "post_friends_cubit":
                  context.read<PostFriendsCubit>()..getFriendsList(),
            },
          ),
        ),
        _buildOption(
          AssetsManager.feelings,
          () => Navigator.pushNamed(
            context,
            FeelingsActivitiesScreen.routeName,
            arguments: {
              "create_post_cubit": context.read<CreatePostCubit>(),
              "feelings_activities_cubit":
                  context.read<FeelingsActivitiesCubit>(),
            },
          ),
        ),
        _buildOption(
          AssetsManager.location,
          () => Navigator.pushNamed(
            context,
            AllUserPlacesScreen.routeName,
            arguments: {
              "create_post_cubit": context.read<CreatePostCubit>(),
              "add_location_cubit": context.read<AddLocationCubit>(),
            },
          ),
        ),
        _buildOption(
          AssetsManager.messageOption,
          () => context.read<CreatePostCubit>().toggleVerticalOption(true),
          isMoreOption: true,
        ),
      ],
    );
  }

  Widget _buildOption(
    String assetsName,
    Function() onTap, {
    bool isMoreOption = false,
  }) {
    return InkWell(
      onTap: onTap,
      child:
          isMoreOption
              ? Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.more_horiz, color: ColorManager.white),
              )
              : SvgPicture.asset(assetsName),
    );
  }
}

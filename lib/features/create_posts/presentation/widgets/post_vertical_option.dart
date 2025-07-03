import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/utils/helper/snackbar.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/edit_media_cubit/edit_media_cubit.dart';

import '../../../../core/managers/assets_managers.dart';
import '../../../../core/managers/color_manager.dart';
import '../../../../core/managers/theme_manager.dart';
import '../blocs/create_post_cubit/create_post_cubit.dart';
import '../screens/create_album_screen.dart';

class PostVerticalOption extends StatelessWidget {
  const PostVerticalOption({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: ColorManager.disActive.withOpacity(0.5)),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildOption("Photo / Video", AssetsManager.photoPost, () {
                      Navigator.of(context).pushNamed(
                        AlbumPhotosScreen.routeName,
                        arguments: {
                          "create_post_cubit": context.read<CreatePostCubit>(),
                          "edit_media_cubit":context.read<EditMediaCubit>()
                        },
                      );
                    }),
                    _buildOption(
                      "Camera",
                      AssetsManager.cameraPost,
                          () {
                        showSnackBar(context, "will be implemented soon",isWarning: true);
                          },
                    ),
                    _buildOption(
                      "Gif",
                      AssetsManager.gifPost,
                          () {
                            showSnackBar(context, "will be implemented soon",isWarning: true);

                          },
                    ),
                    _buildOption(
                      "Reel",
                      AssetsManager.reelPost,
                          () {
                            showSnackBar(context, "will be implemented soon",isWarning: true);

                          },
                    ),
                    // _buildOption(
                    //   "Shami post",
                    //   AssetsManager.shamiPost,
                    //       () {},
                    // ),
                    // _buildOption(
                    //   "Live",
                    //   AssetsManager.live,
                    //       () {},
                    // ),
                    // _buildOption(
                    //   "Camera",
                    //   AssetsManager.cameraPost,
                    //       () {},
                    // ),
                    // _buildOption(
                    //   "Opinion poll",
                    //   AssetsManager.opinionPoll,
                    //   () {},
                    // ),
                    // _buildOption(
                    //   "Personal occasion",
                    //   AssetsManager.occasion,
                    //   () {},
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOption(String label, String assetsName, Function() onTap) {
    return ListTile(
      leading: SvgPicture.asset(assetsName),
      title: Text(
        label,
        style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/locator/service_locator.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/comment_reaction_cubit/comment_reactions_cubit.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/fetch_comments_bloc/fetch_comments_bloc.dart';
import 'package:sloopify_mobile/features/posts/presentation/blocs/fetch_comments_bloc/fetch_comments_event.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_comment_widgets/comments_section.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_comment_widgets/post_comments_header.dart';

import '../widgets/post_comment_widgets/add_comment_sheet.dart';

class CommentsScreen extends StatelessWidget {
  final PostEntity postEntity;

  const CommentsScreen({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "Comments",
        actions: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              AssetsManager.share,
              color: ColorManager.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: PostCommentsHeader(postEntity: postEntity),
                  ),
                ];
              },
              body: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => locator<CommentFetchBloc>()..add(FetchInitialComments())),
                  BlocProvider(
                    create: (context) => locator<CommentInteractionCubit>(),
                  ),
                ],
                child: CommentsSection(),
              ),
            ),
            AddCommentSheet()
          ],
        ),
      ),
    );
  }
}

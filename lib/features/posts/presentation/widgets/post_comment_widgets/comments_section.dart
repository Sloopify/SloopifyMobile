import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/commet_entity.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/post_comment_widgets/one_comment_card.dart';

import '../../blocs/comment_reaction_cubit/comment_reactions_cubit.dart';
import '../../blocs/fetch_comments_bloc/fetch_comments_bloc.dart';
import '../../blocs/fetch_comments_bloc/fetch_comments_event.dart';
import '../../blocs/fetch_comments_bloc/fetch_comments_state.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentFetchBloc, CommentFetchState>(
      builder: (context, state) {
        if (state is CommentFetchLoading || state is CommentFetchInitial) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CommentFetchFailure) {
          return Center(child: Text("Failed: ${state.error}"));
        }

        if (state is CommentFetchSuccess) {
          context.read<CommentInteractionCubit>().setInitialComments(state.comments);

          return BlocBuilder<CommentInteractionCubit, List<CommentEntity>>(
            builder: (context, comments) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                itemCount: comments.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == comments.length && state.hasMore) {
                    context.read<CommentFetchBloc>().add(FetchMoreComments());
                    return Center(child: CircularProgressIndicator());
                  }

                  final comment = comments[index];
                  return OneCommentCard(commentEntity: comment);
                },
              );
            },
          );
        }

        return Container();
      },
    );
  }
}

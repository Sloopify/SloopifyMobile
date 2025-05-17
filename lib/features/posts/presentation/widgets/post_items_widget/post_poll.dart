import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_polls/flutter_polls.dart';

class PostPoll extends StatelessWidget {
  final PostEntity postEntity;

  const PostPoll({super.key, required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return FlutterPolls(
      pollId: postEntity.polls!.id,
      onVoted: (PollOption pollOption, int newTotalVotes) async {
        /// Simulate HTTP request
        await Future.delayed(const Duration(seconds: 1));

        /// If HTTP status is success, return true else false
        return true;
      },
      pollTitle: SizedBox.shrink(),
      pollOptions: List<PollOption>.from(
        postEntity.polls!.pollOptions.map(
          (option) => PollOption(
            title: option.title,
            votes: option.votes,
            id: option.id,
          ),
        ),
      ),
      heightBetweenOptions: 20,
      leadingVotedProgessColor: ColorManager.primaryColor,
      pollOptionsHeight: 30,
      votedPollOptionsRadius: Radius.circular(15),
      votedProgressColor:ColorManager.lightGray ,
      pollOptionsSplashColor: ColorManager.primaryShade1,
      votedCheckmark: SizedBox.shrink(),
      pollOptionsFillColor: ColorManager.lightGray,
      votedPercentageTextStyle: AppTheme.bodyText3.copyWith(color: ColorManager.black),
      votedPollOptionsBorder: Border.all(color: ColorManager.primaryColor),
      pollOptionsBorderRadius: BorderRadius.circular(15),
      votesTextStyle: AppTheme.bodyText3,


    );
  }
}

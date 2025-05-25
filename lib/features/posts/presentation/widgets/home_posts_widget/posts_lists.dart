import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/posts/presentation/widgets/home_posts_widget/post_widget.dart';

import '../../../../../core/managers/assets_managers.dart';
import '../../../../posts/domain/entities/post_entity.dart';
import '../../../domain/entities/post_poll_entity.dart';

class PostsLists extends StatelessWidget {
  const PostsLists({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return PostWidget(
          postEntity: PostEntity(
            feelings: "happy",
            friendsSharing: ["nour", "fadi", "ibrahim"],
            hashtags: ["flutter","test","design","syria"],
            images: [AssetsManager.homeExample2,AssetsManager.homeExample3,AssetsManager.homeExample1],
            id: "1",
            content:
                "Lorem ipsum dolor sit amet consectetur. Volutpat morbi viverra ornare posuere aliquam dictum. Faucibus turpis dignissim massa quisque. Molestie vivamus eget at tristique pharetra. Mi aliquet purus hendrerit malesuada. Dictum convallis volutpat euismod neque tincidunt non ut. Sollicitudin quis cras ut aliquet turpis ut ante morbi. A aliquam volutpat mi sit pulvinar aenean nibh dui mus. Eros feugiat tellus euismod pellentesque. Pellentesque habitasse lacus vitae mattis aliquam blandit malesuada dolor. Viverra quis eu amet morbi libero et nullam auctor. Ipsum neque integer auctor pulvinar.",
            profileImage: AssetsManager.manExample,
            polls: PostPollEntity(
              id: "1",
              pollOptions: [
                PollOption(
                  id: 'option1',
                  title: Text('option1', style: AppTheme.bodyText3),
                  votes: 40,
                ),
                PollOption(
                  id: 'option2',

                  title: Text('option2', style: AppTheme.bodyText3,textAlign: TextAlign.start,),
                  votes: 30,
                ),
                PollOption(
                  id: 'option3',

                  title: Text('option3', style: AppTheme.bodyText3),
                  votes: 20,
                ),
              ],
            ),

            publisherName: "Nour alkhalil",
            postDate: "",
            numberOfComments: 100,
            numberOfLikes: 100,
          ),
        );
      },
    );
  }
}

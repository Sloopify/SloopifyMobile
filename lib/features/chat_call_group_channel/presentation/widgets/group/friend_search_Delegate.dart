import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_event.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/group/group_state.dart';

class FriendSearchDelegate extends SearchDelegate {
  final GroupBloc bloc;

  FriendSearchDelegate(this.bloc);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.add(SearchFriend(query));
    return BlocBuilder<GroupBloc, GroupState>(
      bloc: bloc,
      builder: (context, state) {
        return ListView(
          children:
              state.filteredFriends.map((friend) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/friendlist/group.jpg",
                    ),
                    // NetworkImage(friend.avatarUrl ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      text: query,
                      style: const TextStyle(color: Colors.red),
                      children: [
                        TextSpan(
                          text: friend.name.replaceFirst(query, ''),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => bloc.add(ToggleFriendSelection(friend)),
                );
              }).toList(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Optional: show recent or top friends
  }
}

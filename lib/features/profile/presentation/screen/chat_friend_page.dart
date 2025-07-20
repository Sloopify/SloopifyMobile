import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_friend_cubit.dart';
import '../../../chat_media/presentation/widgets/document_tab.dart';

class ChatFriendPage extends StatelessWidget {
  const ChatFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatFriendCubit()..loadDocuments(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Lorem ipsum'),
            leading: const BackButton(),
            actions: const [Icon(Icons.search)],
            bottom: const TabBar(
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.teal,
              tabs: [
                Tab(text: 'Media'),
                Tab(text: 'Documents'),
                Tab(text: 'Links'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text('Media')),
              DocumentTab(),
              Center(child: Text('Links')),
            ],
          ),
        ),
      ),
    );
  }
}

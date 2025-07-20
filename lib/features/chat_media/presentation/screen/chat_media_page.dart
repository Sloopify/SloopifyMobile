import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/data/datasources/media_local_datasource.dart';
import 'package:sloopify_mobile/features/chat_media/data/repository/media_repository_impl.dart';
import 'package:sloopify_mobile/features/chat_media/domain/usecases/fetch_media_by_date.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_friend_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_media_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/link_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/widgets/document_tab.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/widgets/media_view.dart';

import 'package:sloopify_mobile/features/chat_media/presentation/widgets/link_tabs.dart';

class ChatMediaPage extends StatelessWidget {
  const ChatMediaPage({super.key});
  static const String routeName = 'media_screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => ChatMediaCubit(
                FetchMediaByDate(
                  MediaRepositoryImpl(FakeMediaLocalDataSource()),
                ),
              )..loadMedia(),
        ),
        BlocProvider(create: (_) => ChatFriendCubit()..loadDocuments()),
        BlocProvider(
          create: (_) => LinkCubit()..loadLinks(), // ✅ Don't forget this!
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Lorem ipsum'),
            bottom: const TabBar(
              indicatorColor: Colors.teal,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(text: 'Media'),
                Tab(text: 'Documents'),
                Tab(text: 'Links'),
              ],
            ),
          ),
          body: Builder(
            // ✅ ensure new context with access to providers
            builder:
                (context) => TabBarView(
                  children: [
                    MediaTabView(),
                    const DocumentTab(),
                    const LinksTab(),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}

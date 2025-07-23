import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_state.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/SortBottomSheet%20.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/filter_chip_widget.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/request_list_item.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/search_bar.dart';

class MyRequestsPage extends StatefulWidget {
  const MyRequestsPage({super.key});

  static const routeName = "my_requests_screen";

  @override
  State<MyRequestsPage> createState() => _MyRequestsPageState();
}

class _MyRequestsPageState extends State<MyRequestsPage> {
  bool showSentRequests = true;

  @override
  void initState() {
    super.initState();
    _loadInitialRequests();
  }

  void _loadInitialRequests() {
    final bloc = context.read<FriendBloc>();

    if (showSentRequests) {
      bloc.add(
        LoadSentFriendRequests(
          page: 1,
          perPage: 10,

          sortBy: "name",
          sortOrder: "asc",
          status: "pending",
        ),
      );
    } else {
      bloc.add(
        LoadReceivedFriendRequests(
          page: 1,
          perPage: 10,

          sortBy: "name",
          sortOrder: "asc",
        ),
      );
    }
  }

  void _toggleRequestView(bool isSent) {
    setState(() {
      showSentRequests = isSent;
    });
    _loadInitialRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FriendBloc(context.read()),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'My requests',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              const SizedBox(height: 16),

              // 🔁 Toggle between sent/received
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterChipWidget(
                    label: "Sent",
                    color: showSentRequests ? Colors.teal : Color(0xFFB2DFDB),
                    onTap: () => _toggleRequestView(true),
                  ),
                  FilterChipWidget(
                    label: "Received",
                    color: !showSentRequests ? Colors.teal : Color(0xFFB2DFDB),
                    onTap: () => _toggleRequestView(false),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    showSentRequests ? "Sent requests" : "Received requests",
                    style: const TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder:
                            (context) => SortBottomSheet(
                              onSelect: (String option) {
                                // Add sorting if needed
                              },
                            ),
                      );
                    },
                    child: const Text(
                      "Sort",
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(
                child: BlocBuilder<FriendBloc, FriendState>(
                  builder: (context, state) {
                    if (state is FriendLoading ||
                        state is ReceivedFriendRequestLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SentFriendRequestLoaded &&
                        showSentRequests) {
                      return ListView.builder(
                        itemCount: state.sentRequests.length,
                        itemBuilder: (context, index) {
                          final friend = state.sentRequests[index];
                          return RequestListItem(
                            request: {
                              'name': friend.name,
                              'mutualFriends': 0,
                              'imageUrl': friend.avatarUrl,
                            },
                          );
                        },
                      );
                    } else if (state is ReceivedFriendRequestLoaded &&
                        !showSentRequests) {
                      return ListView.builder(
                        itemCount: state.requests.length,
                        itemBuilder: (context, index) {
                          final friend = state.requests[index];
                          return RequestListItem(
                            request: {
                              'name': friend.name,
                              'mutualFriends': 0,
                              'imageUrl': friend.avatarUrl,
                            },
                          );
                        },
                      );
                    } else if (state is FriendError ||
                        state is ReceivedFriendRequestError) {
                      return Center(
                        child: Text(
                          "Error: ${state is FriendError ? state.message : (state as ReceivedFriendRequestError).message}",
                        ),
                      );
                    }

                    return const Center(child: Text("No data"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

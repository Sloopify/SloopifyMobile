import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/data/datasources/FriendListRepositoryImpl.dart';
import 'package:sloopify_mobile/features/friend_list/data/datasources/friend_list_remote_data_source.dart';
import 'package:sloopify_mobile/features/friend_list/data/repository/friend_list_repository_impl.dart';
import 'package:sloopify_mobile/features/friend_list/domain/repository/friend_list_repository.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_bloc.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/blocs/friend_list_event.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/friendship_request.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/myRequests.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/screen/youMayKnowScreen.dart';

class FilterButton extends StatelessWidget {
  final String text;

  const FilterButton(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          final remoteDataSource = FriendListRepositoryImpl(
            Dio() as FriendRemoteDataSource,
          );

          switch (text.toLowerCase()) {
            case 'friendship requests':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (_) => FriendBloc(
                              remoteDataSource as FriendListRepository,
                            )..add(LoadFriends(page: 1, perPage: 10)),
                        child: const FriendListPage(),
                      ),
                ),
              );
              break;

            case 'my requests':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (_) => FriendBloc(
                              remoteDataSource as FriendListRepository,
                            )..add(LoadFriends(page: 1, perPage: 10)),
                        child: const MyRequestsPage(),
                      ),
                ),
              );
              break;

            case 'you may know':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create:
                            (_) => FriendBloc(
                              remoteDataSource as FriendListRepository,
                            )..add(LoadFriends(page: 1, perPage: 10)),
                        child: const YouMayKnowPage(),
                      ),
                ),
              );
              break;

            default:
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Page not found')));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFDAF4F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xff14B8A6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

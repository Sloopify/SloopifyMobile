import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/data/models/user_model.dart';
import '../cubit/profile_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required UserModel user});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state;

    return Column(
      children: [
        const CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('assets/3.jpg'),
        ),
        const SizedBox(height: 12),
        Text(state.name, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}

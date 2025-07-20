import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/danger_zone.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/shared_groups.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/action_buttons.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/media_section.dart';
import 'package:sloopify_mobile/features/profile/presentation/widgets/options_list.dart';
import '../cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  static const routeName = "profile_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Profile', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage(
                      'assets/images/friendlist/3.jpg',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  const ActionButtons(),
                  const SizedBox(height: 20),
                  MediaSection(media: state.media),
                  const Divider(height: 32),
                  const OptionsList(),
                  const Divider(height: 32),
                  const SharedGroupsSection(),
                  const Divider(height: 32),
                  const DangerZoneSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

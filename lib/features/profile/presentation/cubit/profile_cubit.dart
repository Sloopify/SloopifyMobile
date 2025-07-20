import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part '../blocs/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.initial());

  void loadProfile() {
    // Fetch user data from repo if needed
    emit(
      state.copyWith(
        name: "Lorem Ipsum",
        media: [
          'assets/images/friendlist/media1.jpg',
          'assets/images/friendlist/media2.jpg',
          'assets/images/friendlist/media3.jpg',
          'assets/images/friendlist/media4.jpg',
          'assets/images/friendlist/media5.jpg',
          'assets/images/friendlist/media6.jpg',
          'assets/images/friendlist/media7.jpg',
          'assets/images/friendlist/media8.jpg',
          'assets/images/friendlist/media9.jpg',
          'assets/images/friendlist/media10.jpg',
          'assets/images/friendlist/media11.jpg',
          'assets/images/friendlist/media12.jpg',
        ],
      ),
    );
  }
}

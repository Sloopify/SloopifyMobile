import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_profile_entity.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoState.empty());

  void getAllInterests() {
    List <String> interests= [
      'Art',
      'cars',
      'sports',
      'Fitness',
      'Medical',
      'Travel',
      'Fashion',
      'Technology',
      'Animals',
      'Beauty',
      'Music',
      'Health',
      'Animals',
      'Beauty',
      'Music',
    ];
    emit(state.copyWth(interests: interests));
  }
  void setInterest(String interest ){
    emit(state.copyWth(selectedInterest: interest));
  }
  void setGender(Gender gender ){
    emit(state.copyWth(selectedGender: gender));
  }
  void setBirthDay(DateTime date ){
    emit(state.copyWth(selectedBirthDay: date));
  }
  void setBio(String bio ){
    emit(state.copyWth(bio: bio));
  }
  void setEducation(String education ){
    emit(state.copyWth(education: education));
  }
  void setExperience(String experience ){
    emit(state.copyWth( experience: experience));
  }
  void setJobs(String jobs ){
    emit(state.copyWth( jobs: jobs));
  }
  void setSkills(String skills ){
    emit(state.copyWth( skills: skills));
  }
  void setLinks(String links ){
    emit(state.copyWth( links: links));
  }
  void setLocation(String location ){
    emit(state.copyWth( location: location));
  }
}

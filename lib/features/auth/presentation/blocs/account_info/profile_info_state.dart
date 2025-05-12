part of 'profile_info_cubit.dart';

class ProfileInfoState extends Equatable {
  final List<String> interests;
  final UserProfileEntity userProfileEntity;

  const ProfileInfoState({
    required this.interests,
    required this.userProfileEntity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [interests, userProfileEntity];

  factory ProfileInfoState.empty() {
    return ProfileInfoState(
      interests: [],
      userProfileEntity: UserProfileEntity.empty(),
    );
  }

  ProfileInfoState copyWth({
    List<String>? interests,
    String? selectedInterest,
    Gender? selectedGender,
    DateTime? selectedBirthDay,
    String? bio,
    String? education,
    String? skills,
    String? links,
    String? location,
    String? experience,
    String?jobs
  }) {
    return ProfileInfoState(
      interests: interests ?? this.interests,
      userProfileEntity: userProfileEntity.copyWith(
        birthDay: selectedBirthDay ?? userProfileEntity.birthDay,
        gender: selectedGender ?? userProfileEntity.gender,
        interest: selectedInterest ?? userProfileEntity.interest,
        bio: bio??userProfileEntity.bio,
        education: education??userProfileEntity.education,
        links: links??userProfileEntity.links,
        location: location??userProfileEntity.location,
        skills: skills??userProfileEntity.skills,
        jobs: jobs??userProfileEntity.jobs,
        experience: experience??userProfileEntity.experience
      ),
    );
  }
}

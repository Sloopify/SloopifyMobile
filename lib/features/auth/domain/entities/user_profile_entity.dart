import 'package:equatable/equatable.dart';

enum Gender { male, female, none }

class UserProfileEntity extends Equatable {
  final String interest;
  final Gender gender;
  final DateTime birthDay;
  final String bio;
  final String education;
  final String jobs;
  final String skills;
  final String links;
  final String location;
  final String experience;

  UserProfileEntity({
    required this.gender,
    required this.birthDay,
    required this.interest,
    required this.bio,
    required this.education,
    required this.jobs,
    required this.links,
    required this.location,
    required this.skills,
    required this.experience,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    interest,
    gender,
    birthDay,
    bio,
    links,
    skills,
    location,
    education,
    jobs,
    experience,
  ];

  factory UserProfileEntity.empty() {
    return UserProfileEntity(
      gender: Gender.none,
      birthDay: DateTime.now(),
      interest: "",
      bio: "",
      education: "",
      jobs: "",
      links: "",
      location: "",
      skills: "",
      experience: "",
    );
  }

  UserProfileEntity copyWith({
    String? interest,
    Gender? gender,
    DateTime? birthDay,
    String? bio,
    String? education,
    String? skills,
    String? links,
    String? location,
     String? experience,
    String?jobs
  }) {
    return UserProfileEntity(
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      interest: interest ?? this.interest,
      experience: experience??this.experience,
      jobs: jobs??this.jobs,
      skills: skills??this.skills,
      location: location??this.location,
      links: links??this.links,
      education: education??this.education,
       bio: bio??this.bio

    );
  }
}

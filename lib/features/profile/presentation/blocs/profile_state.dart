part of '../cubit/profile_cubit.dart';

class ProfileState extends Equatable {
  final String name;
  final List<String> media;

  const ProfileState({required this.name, required this.media});

  factory ProfileState.initial() => const ProfileState(name: '', media: []);

  ProfileState copyWith({String? name, List<String>? media}) {
    return ProfileState(name: name ?? this.name, media: media ?? this.media);
  }

  @override
  List<Object?> get props => [name, media];
}

import 'package:equatable/equatable.dart';

class StoryUser extends Equatable{
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  StoryUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  factory StoryUser.fromJson(Map<String, dynamic> json) {
    return StoryUser(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>[id,firstName,lastName,email,image];
}

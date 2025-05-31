import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/phone_number_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';

class UserEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final int id;
  final PhoneNumberEntity phoneNumberEntity;
  final bool emailVerified;
  final Gender gender;
  final String status;
  final double age;
  final String birthDate;
  final String bio;
  final String country;
  final String city;
  final String provider;
  final String image;
  final String referralCode;
  final String referralLink;
  final String referredBy;
  final String lastLoginDate;
  final String creationDate;
  final String updatedAt;

  const UserEntity({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phoneNumberEntity,
    required this.email,
    required this.image,
    required this.city,
    required this.id,
    required this.status,
    required this.creationDate,
    required this.referredBy,
    required this.bio,
    required this.country,
    required this.age,
    required this.birthDate,
    required this.emailVerified,
    required this.lastLoginDate,
    required this.provider,
    required this.referralCode,
    required this.referralLink,
    required this.updatedAt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    updatedAt,
    referralLink,
    referralCode,
    referredBy,
    lastLoginDate,
    emailVerified,
    birthDate,
    age,
    country,
    city,
    firstName,
    lastName,
    gender,
    phoneNumberEntity,
    email,
    image,
    city,
    id,
    status,
    creationDate,
    referredBy,
    bio,
  ];
}

import 'package:sloopify_mobile/features/auth/data/models/phone_number_model.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/user_profile_entity.dart';

import '../../domain/entities/phone_number_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.phoneNumberEntity,
    required super.email,
    required super.image,
    required super.city,
    required super.id,
    required super.status,
    required super.creationDate,
    required super.referredBy,
    required super.bio,
    required super.country,
    required super.age,
    required super.birthDate,
    required super.emailVerified,
    required super.lastLoginDate,
    required super.provider,
    required super.referralCode,
    required super.referralLink,
    required super.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        firstName: json["first_name"]??"",
        lastName: json["last_name"]??"",
        gender: json["gender"]=="female"?Gender.female:Gender.male,
        phoneNumberEntity: PhoneNumberModel.fromJson(json["phone"]),
        email: json["email"]??"",
        image: json["image"]??"",
        city: json["city"]??"",
        id: json["id"]??0,
        status: json["status"]??"",
        creationDate: json["created_at"]??"",
        referredBy: json["reffered_by"]??"",
        bio: json["bio"]??"",
        country: json["country"]??"",
        age: json["age"]??0.0,
        birthDate: json["birthday"]??"",
        emailVerified: json["email_verified"]??false,
        lastLoginDate: json["last_login_at"]??"",
        provider: json["provider"]??"",
        referralCode: json["referral_code"]??"",
        referralLink: json["referral_link"]??"",
        updatedAt: json["updated_at"]??""
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "gender": gender == Gender.female ? "female" : "male",
      "phone": (phoneNumberEntity as PhoneNumberModel).toJson(),
      "email": email,
      "image": image,
      "city": city,
      "id": id,
      "status": status,
      "created_at": creationDate,
      "reffered_by": referredBy,
      "bio": bio,
      "country": country,
      "age": age,
      "birthday": birthDate,
      "email_verified": emailVerified,
      "last_login_at": lastLoginDate,
      "provider": provider,
      "referral_code": referralCode,
      "referral_link": referralLink,
      "updated_at": updatedAt,
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    Gender? gender,
    PhoneNumberEntity? phoneNumberEntity,
    String? email,
    String? image,
    String? city,
    int? id,
    String? status,
    String? creationDate,
    String? referredBy,
    String? bio,
    String? country,
    double? age,
    String? birthDate,
    bool? emailVerified,
    String? lastLoginDate,
    String? provider,
    String? referralCode,
    String? referralLink,
    String? updatedAt,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      phoneNumberEntity: phoneNumberEntity ?? this.phoneNumberEntity,
      email: email ?? this.email,
      image: image ?? this.image,
      city: city ?? this.city,
      id: id ?? this.id,
      status: status ?? this.status,
      creationDate: creationDate ?? this.creationDate,
      referredBy: referredBy ?? this.referredBy,
      bio: bio ?? this.bio,
      country: country ?? this.country,
      age: age ?? this.age,
      birthDate: birthDate ?? this.birthDate,
      emailVerified: emailVerified ?? this.emailVerified,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      provider: provider ?? this.provider,
      referralCode: referralCode ?? this.referralCode,
      referralLink: referralLink ?? this.referralLink,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

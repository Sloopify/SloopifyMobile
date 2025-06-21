import 'package:equatable/equatable.dart';

class SignupDataEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isCheckedTerms;
  final String mobileNumber;
  final String countryCode;
  final String fullPhoneNumber;

  const SignupDataEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isCheckedTerms,
    required this.mobileNumber,
    required this.countryCode,
    required this.fullPhoneNumber,
  });

  factory SignupDataEntity.empty() {
    return SignupDataEntity(
      confirmPassword: '',
      email: '',
      password: '',
      firstName: '',
      lastName: '',
      isCheckedTerms: false,
      countryCode: '+963',
      fullPhoneNumber: "",
      mobileNumber: '',
    );
  }

  @override
  List<Object> get props => [
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
    isCheckedTerms,
    mobileNumber,
    countryCode,
    fullPhoneNumber,
  ];

  SignupDataEntity copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isCheckedTerms,
    String? mobileNumber,
    String? countryCode,
    String? fullPhoneNumber,
  }) {
    return SignupDataEntity(
      firstName: firstName ?? this.firstName,
      fullPhoneNumber: fullPhoneNumber ?? this.fullPhoneNumber,
      countryCode: countryCode ?? this.countryCode,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isCheckedTerms: isCheckedTerms ?? this.isCheckedTerms,
    );
  }
}

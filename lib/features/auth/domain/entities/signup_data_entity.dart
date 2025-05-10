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

  const SignupDataEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isCheckedTerms,
    required this.mobileNumber,
    required this.countryCode
  });

  factory SignupDataEntity.empty() {
    return SignupDataEntity(
      confirmPassword: '',
      email: '',
      password: '',
      firstName: '',
      lastName: '',
      isCheckedTerms: false,
      countryCode: '',
      mobileNumber: ''
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
    countryCode
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
  }) {
    return SignupDataEntity(
      firstName: firstName ?? this.firstName,
      countryCode: countryCode??this.countryCode,
      mobileNumber: mobileNumber??this.mobileNumber,
      lastName: firstName ?? this.firstName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isCheckedTerms: isCheckedTerms ?? this.isCheckedTerms,
    );
  }
}

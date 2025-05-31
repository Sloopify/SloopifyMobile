import 'package:equatable/equatable.dart';

class PhoneNumberEntity extends Equatable {
  final String fullNumber;
  final String code;
  final String phoneNumber;
  final bool isValid;

  const PhoneNumberEntity({
    required this.code,
    required this.phoneNumber,
    required this.fullNumber,
    required this.isValid,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [fullNumber,code,phoneNumber,isValid];
}

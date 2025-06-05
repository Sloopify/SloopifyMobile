import 'package:equatable/equatable.dart';

import 'otp_data_entity.dart';

class ForgetPasswordDataEntity extends Equatable{
final OtpDataEntity otpDataEntity;
  final String confirmNewPassword;
  final String newPassword;
  const ForgetPasswordDataEntity({required this.confirmNewPassword,required this.otpDataEntity,required this.newPassword});
  @override
  // TODO: implement props
  List<Object?> get props => [otpDataEntity,confirmNewPassword,newPassword];

}
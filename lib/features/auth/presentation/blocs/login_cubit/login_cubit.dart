import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_login_data_entity.dart';

import '../../../domain/entities/otp_login_data_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.empty());


  void setEmailOrPhoneNumber(String emailOrPhoneNumber) {
    emit(state.copyWith(email: emailOrPhoneNumber, loginStatus: LoginStatus.init));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password, loginStatus: LoginStatus.init));
  }
  void setOtpEmail(String password) {
    emit(state.copyWith(password: password, otpLoginStatus: OtpLoginStatus.init));
  }
  void setOtpCode(String code) {
    emit(state.copyWith(otpCode: code, otpLoginStatus: OtpLoginStatus.init));
  }
}

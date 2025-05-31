import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_login_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/email_login_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/phone_login_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_otp_code_login.dart';
import 'package:sloopify_mobile/features/auth/presentation/screens/login_with_otp_code.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/otp_login_data_entity.dart';
import '../../../domain/use_cases/opt_login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final EmailLoginUseCase emailLoginUseCase;
  final PhoneLoginUseCase phoneLoginUseCase;


  LoginCubit({
    required this.phoneLoginUseCase,
    required this.emailLoginUseCase,
  }) : super(LoginState.empty());

  void setEmail(String email) {
    emit(state.copyWith(email: email, loginStatus: LoginStatus.init));
  }

  void setPhoneNumber(String phoneNumber) {
    emit(
      state.copyWith(phoneNumber: phoneNumber, loginStatus: LoginStatus.init),
    );
  }

  void setFullMobileNumber(String full) {
    emit(state.copyWith(fullPhoneNumber: full, loginStatus: LoginStatus.init));
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password, loginStatus: LoginStatus.init));
  }
  void setDialCode(String dialCode) {
    emit(
      state.copyWith(countryCode: dialCode, loginStatus: LoginStatus.init),
    );
  }





  void setLoginType(LoginType loginType) {
    emit(
      state.copyWith(loginType: loginType, loginStatus: LoginStatus.init),
    );
  }

  void loginWithEmail() async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    final res = await emailLoginUseCase(loginDataEntity: state.loginDataEntity);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(loginStatus: LoginStatus.done));
    });
  }
  void loginWithPhone() async {
    if (state.loginDataEntity.loginType == LoginType.phoneNumber) {
      if (state.loginDataEntity.countryCode == "+963") {
        setFullMobileNumber(
          '${state.loginDataEntity.countryCode}${state.loginDataEntity.phoneNumber!.substring(1)}',
        );
      } else {
        setFullMobileNumber(
          '${state.loginDataEntity.countryCode}${state.loginDataEntity.phoneNumber}',
        );
      }
    }
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    final res = await phoneLoginUseCase(loginDataEntity: state.loginDataEntity);
    res.fold((f) {
      _mapFailureToState(emit, f, state);
    }, (data) async {
      emit(state.copyWith(loginStatus: LoginStatus.done));
    });
  }
  _mapFailureToState(emit, Failure f, LoginState state) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(loginStatus: LoginStatus.noInternet));

      case NetworkErrorFailure f:
        emit(state.copyWith(
            loginStatus: LoginStatus.networkError, errorMessage: f.message));
    }
  }
  }
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_otp_code_login.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/verify_otp_entity.dart';
import '../../../domain/use_cases/opt_login_use_case.dart';

part 'login_with_otp_state.dart';

class LoginWithOtpCubit extends Cubit<LoginWithOtpState> {
  final OptLoginUseCase optLoginUseCase;
  final VerifyOtpCodeLogin verifyOtpCodeLogin;

  LoginWithOtpCubit({
    required this.verifyOtpCodeLogin,
    required this.optLoginUseCase,
  }) : super(LoginWithOtpState.empty());
  Timer? _timer;

  void setLoginType(OtpSendType otpType) {
    emit(state.copyWith(type: otpType, otpLoginStatus: OtpLoginStatus.init));
  }

  void setEmail(String email) {
    emit(state.copyWith(email: email, otpLoginStatus: OtpLoginStatus.init));
  }
  void setHasPhoneNumberError(bool value) {
    emit(state.copyWith(hasPhoneNumberError: value, otpLoginStatus: OtpLoginStatus.init));
  }
  void setPhoneNumber(String phoneNumber) {
    emit(
      state.copyWith(
        phoneNumbers: phoneNumber,
        otpLoginStatus: OtpLoginStatus.init,
      ),
    );
  }

  void setFullMobileNumber(String full) {
    emit(
      state.copyWith(
        fullPhoneNUmber: full,
        otpLoginStatus: OtpLoginStatus.init,
      ),
    );
  }

  void setDialCode(String dialCode) {
    emit(
      state.copyWith(
        countryCode: dialCode,
        otpLoginStatus: OtpLoginStatus.init,
      ),
    );
  }

  void setOtpCode(String otp) {
    emit(
      state.copyWith(
        otpCode: otp,
        verifyOtpLoginStatus: VerifyOtpLoginStatus.init,
        otpLoginStatus: OtpLoginStatus.init
      ),
    );
  }
  Future<void> startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        emit(
          state.copyWith(
              timerSeconds: state.timerSeconds - 1,
              isTimerFinished: false,
              verifyOtpLoginStatus: VerifyOtpLoginStatus.init,
              otpLoginStatus: OtpLoginStatus.init
          ),
        );
      } else {
        emit(
          state.copyWith(
            timerSeconds: 0,
            isTimerFinished: true,
              verifyOtpLoginStatus: VerifyOtpLoginStatus.init,
              otpLoginStatus: OtpLoginStatus.init
          ),
        );
        _timer?.cancel();
      }
    });
  }
  void otpLogin({bool fromReset=false}) async {
    if (state.otpDataEntity.type == OtpSendType.phone) {
      if (state.otpDataEntity.countryCode == "+963") {
        setFullMobileNumber(
          '${state.otpDataEntity.countryCode}${state.otpDataEntity.phoneNumbers!.substring(1)}',
        );
      } else {
        setFullMobileNumber(
          '${state.otpDataEntity.countryCode}${state.otpDataEntity.phoneNumbers}',
        );
      }
    }
    emit(state.copyWith(otpLoginStatus: OtpLoginStatus.loading));
    final res = await optLoginUseCase(otpDataEntity: state.otpDataEntity);
    res.fold(
      (f) {
        _mapFailureToState(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(otpLoginStatus:fromReset? OtpLoginStatus.init: OtpLoginStatus.success));
      },
    );
  }

  Future<void> verifyOtpLogin() async {
    VerifyOtpEntity verifyOtpEntity = VerifyOtpEntity(
      otp:state.verifyOtpEntity.otp,
      otpSendType: state.otpDataEntity.type,
      email: state.otpDataEntity.email,
      phone: state.otpDataEntity.fullPhoneNumber,
    );
    emit(state.copyWith(verifyOtpLoginStatus: VerifyOtpLoginStatus.loading));
    final res = await verifyOtpCodeLogin(verifyOtpEntity: verifyOtpEntity);
    res.fold(
      (f) {
        _mapFailureVerifyLoginToState(emit, f, state);
      },
      (data) async {
        emit(
          state.copyWith(verifyOtpLoginStatus: VerifyOtpLoginStatus.success),
        );
      },
    );
  }

  _mapFailureToState(emit, Failure f, LoginWithOtpState state) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(otpLoginStatus: OtpLoginStatus.offline));

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            otpLoginStatus: OtpLoginStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureVerifyLoginToState(emit, Failure f, LoginWithOtpState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(verifyOtpLoginStatus: VerifyOtpLoginStatus.offline),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            verifyOtpLoginStatus: VerifyOtpLoginStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}

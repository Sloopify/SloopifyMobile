import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/forget_password_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/request_code_forget_password.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_code_forget_password_use_case.dart';

import '../../../../../core/errors/failures.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final RequestCodeForgetPasswordUseCase requestCodeForgetPasswordUseCase;
  final VerifyCodeForgetPasswordUseCase verifyCodeForgetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ForgetPasswordCubit({
    required this.changePasswordUseCase,
    required this.verifyCodeForgetPasswordUseCase,
    required this.requestCodeForgetPasswordUseCase,
  }) : super(ForgetPasswordState.empty());

  void setLoginType(OtpSendType otpType) {
    emit(
      state.copyWith(otpSendType: otpType, otpSendStatus: OtpSendStatus.init),
    );
  }

  void setEmail(String email) {
    emit(state.copyWith(email: email, otpSendStatus: OtpSendStatus.init));
  }

  void setNewPassword(String password) {
    emit(
      state.copyWith(
        newPassword: password,
        otpSendStatus: OtpSendStatus.init,
        verifyOtpStatus: VerifyOtpStatus.init,
        submitForgetPasswordStatus: SubmitForgetPasswordStatus.init,
      ),
    );
  }
  void setConfirmNewPassword(String password) {
    emit(
      state.copyWith(
        confirmNewPassword: password,
        otpSendStatus: OtpSendStatus.init,
        verifyOtpStatus: VerifyOtpStatus.init,
        submitForgetPasswordStatus: SubmitForgetPasswordStatus.init,
      ),
    );
  }

  void setHasPhoneNumberError(bool value) {
    emit(
      state.copyWith(
        hasPhoneNumberError: value,
        otpSendStatus: OtpSendStatus.init,
      ),
    );
  }

  void setPhoneNumber(String phoneNumber) {
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        otpSendStatus: OtpSendStatus.init,
      ),
    );
  }

  void setFullMobileNumber(String full) {
    emit(
      state.copyWith(fullPhoneNumber: full, otpSendStatus: OtpSendStatus.init),
    );
  }

  void setDialCode(String dialCode) {
    emit(
      state.copyWith(countryCode: dialCode, otpSendStatus: OtpSendStatus.init),
    );
  }

  void setOtpCode(String otp) {
    emit(
      state.copyWith(
        otpCode: otp,
        verifyOtpStatus: VerifyOtpStatus.init,
        otpSendStatus: OtpSendStatus.init,
      ),
    );
  }

  void requestOtp() async {
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
    emit(state.copyWith(otpSendStatus: OtpSendStatus.loading));
    final res = await requestCodeForgetPasswordUseCase(
      otpDataEntity: state.otpDataEntity,
    );
    res.fold(
      (f) {
        _mapFailureToState(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(otpSendStatus: OtpSendStatus.success));
      },
    );
  }

  Future<void> verifyOtpLogin() async {
    VerifyOtpEntity verifyOtpEntity = VerifyOtpEntity(
      otp: state.verifyOtpEntity.otp,
      otpSendType: state.otpDataEntity.type,
      email: state.otpDataEntity.email,
      phone: state.otpDataEntity.fullPhoneNumber,
    );
    emit(state.copyWith(verifyOtpStatus: VerifyOtpStatus.loading));
    final res = await verifyCodeForgetPasswordUseCase(
      verifyOtpEntity: verifyOtpEntity,
    );
    res.fold(
      (f) {
        _mapFailureVerifyToState(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(verifyOtpStatus: VerifyOtpStatus.success));
      },
    );
  }

  Future<void> changePassword() async {
    ForgetPasswordDataEntity forgetPasswordDataEntity =
        ForgetPasswordDataEntity(
          otpDataEntity: state.otpDataEntity,
          confirmNewPassword: state.confirmNewPassword,
          newPassword: state.newPassword,
        );
    emit(
      state.copyWith(
        submitForgetPasswordStatus: SubmitForgetPasswordStatus.loading,
      ),
    );
    final res = await changePasswordUseCase(
      forgetPasswordDataEntity: forgetPasswordDataEntity,
    );
    res.fold(
      (f) {
        _mapFailureChangePassword(emit, f, state);
      },
      (data) async {
        emit(
          state.copyWith(
            submitForgetPasswordStatus: SubmitForgetPasswordStatus.success,
          ),
        );
      },
    );
  }

  _mapFailureToState(emit, Failure f, ForgetPasswordState state) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(otpSendStatus: OtpSendStatus.offline));

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            otpSendStatus: OtpSendStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureVerifyToState(emit, Failure f, ForgetPasswordState state) {
    switch (f) {
      case OfflineFailure():
        emit(state.copyWith(verifyOtpStatus: VerifyOtpStatus.offline));

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            verifyOtpStatus: VerifyOtpStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }

  _mapFailureChangePassword(emit, Failure f, ForgetPasswordState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            submitForgetPasswordStatus: SubmitForgetPasswordStatus.offline,
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            submitForgetPasswordStatus: SubmitForgetPasswordStatus.error,
            errorMessage: f.message,
          ),
        );
    }
  }
}

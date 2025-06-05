import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/otp_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/signup_data_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/register_otp_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_otp_register_use_case.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';

import '../../../../../core/errors/failures.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignupUseCase signupUseCase;
  final RegisterOtpUseCase registerOtpUseCase;
  final VerifyOtpRegisterUseCase verifyOtpRegisterUseCase;

  SignUpCubit({
    required this.verifyOtpRegisterUseCase,
    required this.registerOtpUseCase,
    required this.signupUseCase,
  }) : super(SignUpState.empty());

  void setFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName, signupStatus: SignupStatus.init));
  }

  void setLastName(String lastName) {
    emit(state.copyWith(lastName: lastName, signupStatus: SignupStatus.init));
  }
  void setHasPhoneNumberError(bool value) {
    emit(state.copyWith(hssPhoneNumberError: value, signupStatus: SignupStatus.init));
  }
  void setEmail(String email) {
    emit(state.copyWith(email: email, signupStatus: SignupStatus.init));
  }

  void setMobileNumber(String mobileNumber) {
    emit(
      state.copyWith(
        mobileNumber: mobileNumber,
        signupStatus: SignupStatus.init,
      ),
    );
  }

  void setCountryCode(String countryCode) {
    emit(
      state.copyWith(countryCode: countryCode, signupStatus: SignupStatus.init),
    );
  }

  void setOtpType(OtpSendType otpType) {
    emit(state.copyWith(otpSendType: otpType, signupStatus: SignupStatus.init));
  }

  void setOtpCode(String code) {
    emit(state.copyWith(otpCode: code, signupStatus: SignupStatus.init,otpRegisterStatus: OtpRegisterStatus.init));
  }

  void setFullPhoneNumber(String fullPhoneNumber) {
    emit(
      state.copyWith(
        fullPhoneNumber: fullPhoneNumber,
        signupStatus: SignupStatus.init,
      ),
    );
  }

  void setPassword(String password) {
    emit(state.copyWith(password: password, signupStatus: SignupStatus.init));
  }

  void setCheckTerms(bool isChecked) {
    emit(
      state.copyWith(
        isCheckedTerms: isChecked,
        signupStatus: SignupStatus.init,
      ),
    );
  }

  void setConfirmPassword(String confirmPassword) {
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        signupStatus: SignupStatus.init,
      ),
    );
  }

  void submit() async {
    if (state.signupDataEntity.countryCode == "+963") {
      setFullPhoneNumber(
        "${state.signupDataEntity.countryCode}${state.signupDataEntity.mobileNumber.substring(1)}",
      );
    } else {
      setFullPhoneNumber(
        "${state.signupDataEntity.countryCode}${state.signupDataEntity.mobileNumber}",
      );
    }
    emit(state.copyWith(signupStatus: SignupStatus.loading));
    final res = await signupUseCase(signupDataEntity: state.signupDataEntity);
    res.fold(
      (f) {
        _mapFailureToState(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(signupStatus: SignupStatus.done));
      },
    );
  }

  void registerOtp() async {
    emit(state.copyWith(otpRegisterStatus: OtpRegisterStatus.loading));
    final res = await registerOtpUseCase(otpDataEntity: state.otpDataEntity);
    res.fold(
      (f) {
        _mapRegisterOtpStatus(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(otpRegisterStatus: OtpRegisterStatus.success));
      },
    );
  }

  Future<void> verifyOtpLogin() async {
    VerifyOtpEntity verifyOtpEntity = VerifyOtpEntity(
      otp: state.otpCode,
      otpSendType: state.otpSendType,
      email: state.signupDataEntity.email,
      phone: state.signupDataEntity.fullPhoneNumber,
    );
    emit(state.copyWith(verifyRegisterOtpStatus: VerifyRegisterOtpStatus.loading));
    final res = await verifyOtpRegisterUseCase(verifyOtpEntity: verifyOtpEntity);
    res.fold(
      (f) {
        _mapVerifyRegisterOtpStatus(emit, f, state);
      },
      (data) async {
        emit(
          state.copyWith(verifyRegisterOtpStatus: VerifyRegisterOtpStatus.success),
        );
      },
    );
  }
}

_mapFailureToState(emit, Failure f, SignUpState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          signupStatus: SignupStatus.noInternet,
          errorMessage: 'no_internet_connection'.tr(),
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          signupStatus: SignupStatus.networkError,
          errorMessage: f.message,
        ),
      );
  }
}

_mapRegisterOtpStatus(emit, Failure f, SignUpState state) {
  switch (f) {
    case OfflineFailure():
      emit(
        state.copyWith(
          otpRegisterStatus: OtpRegisterStatus.offline,
          errorMessage: 'no_internet_connection'.tr(),
        ),
      );

    case NetworkErrorFailure f:
      emit(
        state.copyWith(
          otpRegisterStatus: OtpRegisterStatus.error,
          errorMessage: f.message,
        ),
      );
  }
}

  _mapVerifyRegisterOtpStatus(emit, Failure f, SignUpState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            verifyRegisterOtpStatus: VerifyRegisterOtpStatus.offline,
            errorMessage: 'no_internet_connection'.tr(),
          ),
        );

      case NetworkErrorFailure f:
        emit(
          state.copyWith(
            verifyRegisterOtpStatus: VerifyRegisterOtpStatus.error,
            errorMessage: f.message,
          ),
        );
    }
}

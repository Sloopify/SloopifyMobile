import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/reposritory/auth_repo.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/register_otp_use_case.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_otp_register_use_case.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/verify_account/verify_account_cubit.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/otp_data_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';

part 'verify_account_by_signup_state.dart';

class VerifyAccountBySignupCubit extends Cubit<VerifyAccountBySignupState> {
  final RegisterOtpUseCase registerOtpUseCase;
  final VerifyOtpRegisterUseCase verifyOtpRegisterUseCase;

  VerifyAccountBySignupCubit({
    required this.verifyOtpRegisterUseCase,
    required this.registerOtpUseCase,
  }) : super(VerifyAccountBySignupState.empty());

  void setOtpType(OtpSendType otpType, BuildContext context) {
    emit(
      state.copyWith(
        otpSendType: otpType,
        otpRegisterStatus: OtpRegisterStatus.init,
      ),
    );
  }

  void setOtpCode(String code) {
    emit(
      state.copyWith(otpCode: code, otpRegisterStatus: OtpRegisterStatus.init),
    );
  }

  void registerOtp(BuildContext context) async {
    OtpDataEntity otpDataEntity = state.otpDataEntity.copyWith(
      fullPhoneNumber:
          '${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.code}${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.phoneNumber}',
      email: context.read<AuthRepo>().getUserInfo()?.email,
    );

    emit(state.copyWith(otpRegisterStatus: OtpRegisterStatus.loading));
    final res = await registerOtpUseCase(otpDataEntity: otpDataEntity);
    res.fold(
      (f) {
        _mapRegisterOtpStatus(emit, f, state);
      },
      (data) async {
        emit(state.copyWith(otpRegisterStatus: OtpRegisterStatus.success));
      },
    );
  }

  Future<void> verifyOtpLogin(BuildContext context) async {
    VerifyOtpEntity verifyOtpEntity = VerifyOtpEntity(
      otp: state.otpCode,
      otpSendType: state.otpSendType,
      email: context.read<AuthRepo>().getUserInfo()?.email ?? "",
      phone:
          '${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.code}${context.read<AuthRepo>().getUserInfo()?.phoneNumberEntity.phoneNumber}',
    );
    emit(
      state.copyWith(verifyRegisterOtpStatus: VerifyRegisterOtpStatus.loading),
    );
    final res = await verifyOtpRegisterUseCase(
      verifyOtpEntity: verifyOtpEntity,
    );
    res.fold(
      (f) {
        _mapVerifyRegisterOtpStatus(emit, f, state);
      },
      (data) async {
        emit(
          state.copyWith(
            verifyRegisterOtpStatus: VerifyRegisterOtpStatus.success,
          ),
        );
      },
    );
  }

  _mapRegisterOtpStatus(emit, Failure f, VerifyAccountBySignupState state) {
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

  _mapVerifyRegisterOtpStatus(
    emit,
    Failure f,
    VerifyAccountBySignupState state,
  ) {
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
}

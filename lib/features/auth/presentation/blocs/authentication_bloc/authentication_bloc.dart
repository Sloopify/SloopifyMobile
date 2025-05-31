import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/auth/domain/use_cases/verify_token_use_case.dart';

import '../../../../../core/local_storage/preferene_utils.dart';
import '../../../domain/reposritory/auth_repo.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepository;
  final VerifyTokenUseCase verifyTokenUseCase;

  AuthenticationBloc({
    required this.authRepository,
    required this.verifyTokenUseCase,
  }) : super(AuthenticationInitial()) {
    on<AppStarted>((event, emit) async {
      await _appStarted(emit);
    });
    on<UpdateEvent>((event, emit) async {
      await _logIn(emit, event);
    });
    on<LogOutUserEvent>((event, emit) async {
      await _logOut(emit);
    });
  }

  Future<void> _appStarted(Emitter<AuthenticationState> emit) async {
    await decideState(emit);
  }

  Future<void> _logOut(Emitter<AuthenticationState> emit) async {
    emit(AuthenticatationLoading());
    //delete all data saved in shared preference
    await authRepository.deleteUserInfo();
    await PreferenceUtils.clearAll();
    emit(UnauthenticatedState());
  }

  Future<void> _logIn(
    Emitter<AuthenticationState> emit,
    UpdateEvent event,
  ) async {
    emit(AuthenticatationLoading());
    await decideState(emit);
  }

  decideState(Emitter<AuthenticationState> emit) async {
    //check if the user logged in by reading shared preference data from auth repo
    final hasUser = await authRepository.hasUserInfo();
    final hasUserCompletedInfo = authRepository.hesCompletedUserInfo();

    if (!hasUser) {
      // no user so we emit the authenticated state
      emit(UnauthenticatedState());
    } else if (hasUser) {
      //get user info from server to get the latest info
      final res = await verifyTokenUseCase();

      await res.fold(
        (failure) {
          emit(UnauthenticatedState());
        },
        (userData) async {
          //successful so we save the new fetched data
          await authRepository.saveUserInfo(userData.userEntity);
          await authRepository.saveCompleteUserInfo(
            userData.onBoardingDataInfo,
          );
        },
      );

      //get the data from repo
      final userInfo = authRepository.getUserInfo();
      final userCompletedInfo = authRepository.getCompletedUserInfo();
      if (!userInfo!.emailVerified) {
        emit(NotActivatedWithOtpCode());
      } else if (!userCompletedInfo!.image) {
        emit(NotCompletedImageInfo());
      } else if (!userCompletedInfo.gender) {
        emit(NotCompletedGenderInfo());
      } else if (!userCompletedInfo.birthDay) {
        emit(NotCompletedBirthdayInfo());
      } else if (!userCompletedInfo.interests) {
        emit(NotCompetedInterests());
      }else {
        emit(AuthenticatedState());
      }
    }
    }
}

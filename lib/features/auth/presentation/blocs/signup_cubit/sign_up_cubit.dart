import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/features/auth/domain/entities/signup_data_entity.dart';

import '../../../../../core/errors/failures.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.empty());

  void setFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName, signupStatus: SignupStatus.init));
  }

  void setLastName(String lastName) {
    emit(state.copyWith(lastName: lastName, signupStatus: SignupStatus.init));
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
    emit(state.copyWith(signupStatus: SignupStatus.loading, errorMessage: ''));
  }

  _mapFailureToState(emit, Failure f, SignUpState state) {
    switch (f) {
      case OfflineFailure():
        emit(
          state.copyWith(
            signupStatus: SignupStatus.noInternet,
            errorMessage: '',
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
}

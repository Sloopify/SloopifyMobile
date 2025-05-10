import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(VerifyAccountState.empty());


  void setVerifyAccountType(VerifyAccountType type){
    emit(state.copyWith(verifyAccountType: type));
  }
}

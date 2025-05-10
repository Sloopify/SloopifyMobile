part of 'verify_account_cubit.dart';

enum VerifyAccountType { none, email, code }

class VerifyAccountState extends Equatable {
  final VerifyAccountType verifyAccountType;
  final String code;

  final String errorMessage;

  const VerifyAccountState({
    required this.verifyAccountType,
    required this.errorMessage,
    required this.code,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [verifyAccountType, errorMessage, code];

  factory VerifyAccountState.empty() {
    return VerifyAccountState(
      verifyAccountType: VerifyAccountType.none,
      errorMessage: '',
      code: '',
    );
  }

  VerifyAccountState copyWith(
      {String ?code, String ? message, VerifyAccountType? verifyAccountType}) {
    return VerifyAccountState(
        verifyAccountType: verifyAccountType ?? this.verifyAccountType,
        errorMessage: message ?? errorMessage,
        code: code ?? this.code);
  }
}

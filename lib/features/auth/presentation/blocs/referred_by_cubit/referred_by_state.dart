part of 'referred_by_cubit.dart';

enum SubmitReferredByStatus { loading, init, success, error, offline }

class ReferredBtyState extends Equatable {
  final String referredByCode;
  final SubmitReferredByStatus referredByStatus;
  final String errorMessage;

  const ReferredBtyState({
    this.referredByStatus = SubmitReferredByStatus.init,
    this.referredByCode = "",
    this.errorMessage = "",
  });

  // TODO: implement props
  List<Object?> get props => [referredByCode, referredByStatus, errorMessage];

  ReferredBtyState copyWith({
    String? referredBy,
    SubmitReferredByStatus? referredByStatus,
    String? errorMessage,
  }) {
    return ReferredBtyState(
      errorMessage: errorMessage ?? this.errorMessage,
      referredByCode: referredBy ?? referredByCode,
      referredByStatus: referredByStatus ?? this.referredByStatus,
    );
  }
}

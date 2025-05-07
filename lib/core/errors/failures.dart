// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class LocalFailure extends Failure {
  final String message;
  LocalFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class NetworkErrorFailure extends Failure {
  final int? responseCode;
  final String message;
  NetworkErrorFailure({
    required this.message,
     this.responseCode
  });

  @override
  List<Object?> get props => [message,responseCode];
}



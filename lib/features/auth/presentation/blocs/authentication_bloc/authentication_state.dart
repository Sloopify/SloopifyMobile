// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticatationLoading extends AuthenticationState {}

//no user --> show start up (login or search) screen
class UnauthenticatedState extends AuthenticationState {}



//user -> show homepage
class AuthenticatedState extends AuthenticationState {}

class AuthenticatedStateWithGoogle extends AuthenticationState {}

class NotActivatedWithOtpCode extends AuthenticatedState {}

class NotCompletedGenderInfo extends AuthenticatedState {}

class NotCompletedBirthdayInfo extends AuthenticatedState {}

class NotCompletedImageInfo extends AuthenticatedState {}

class NotCompetedInterests extends AuthenticatedState {}

import 'package:equatable/equatable.dart';

enum GmailLoginStatus { init, loading, success, error, offline }

class SocialMediaLoginState extends Equatable {
  final String googleToken;
  final String googleEmail;
  final GmailLoginStatus gmailLoginStatus;
  final String errorMessage;

  const SocialMediaLoginState({
    this.gmailLoginStatus = GmailLoginStatus.init,
    this.googleToken = "",
    this.googleEmail = "",
    this.errorMessage=""
  });

  @override
  // TODO: implement props
  List<Object?> get props => [googleToken, googleEmail, gmailLoginStatus,errorMessage];

  SocialMediaLoginState copyWith({
    String? googleToken,
    String? googleEmail,
    GmailLoginStatus? gmailLoginStatus,
    String?errorMessage
  }) {
    return SocialMediaLoginState(
      gmailLoginStatus: gmailLoginStatus ?? this.gmailLoginStatus,
      googleEmail: googleEmail ?? this.googleEmail,
      googleToken: googleToken ?? this.googleToken,errorMessage: errorMessage??this.errorMessage
    );
  }
}

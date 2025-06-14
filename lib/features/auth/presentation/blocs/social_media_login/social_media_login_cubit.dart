import 'package:bloc/bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sloopify_mobile/core/local_storage/preferene_utils.dart';
import 'package:sloopify_mobile/core/local_storage/prefernces_key.dart';
import 'package:sloopify_mobile/features/auth/presentation/blocs/social_media_login/social_media_login_state.dart';

class SocialMediaLoginCubit extends Cubit<SocialMediaLoginState> {
  SocialMediaLoginCubit() : super(SocialMediaLoginState());

  Future<void> submitGmailSignIn() async {
    emit(state.copyWith(gmailLoginStatus: GmailLoginStatus.loading));

    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      print(googleSignIn.currentUser);

      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        GoogleSignInAuthentication authentication =
            await account.authentication;
        var tokenId = authentication.idToken;
        var email = account.email;
        var userDisplayName = account.displayName;
        var photoUrl = account.photoUrl;

        print("********************Gmail Information**********************");
        print("tokenId = $tokenId");
        print("email = $email");
        print("userDisplayName = $userDisplayName");
        print("photoUrl = $photoUrl");
        if (tokenId != null) {
          await PreferenceUtils.setString(SharedPrefsKey.googleToken, tokenId);
        }
        emit(
          state.copyWith(
            gmailLoginStatus: GmailLoginStatus.success,
            googleEmail: email,
            googleToken: tokenId,
          ),
        );
      } else {
        emit(
          state.copyWith(
            gmailLoginStatus: GmailLoginStatus.error,
            errorMessage:
                'حدث خطأ اثناء تسجيل دخول غوغل, يرجى إعادة المحاولة لاحقا',
          ),
        );
      }
    } catch (e) {
      print("eeeeeeee${e}");
      emit(
        state.copyWith(
          gmailLoginStatus: GmailLoginStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

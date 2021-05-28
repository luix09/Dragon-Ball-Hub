import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_exception_handler.dart';

class AuthHelper {
  final FirebaseAuth auth;
  AuthHelper({required this.auth});

  Future<AuthResultStatus?> userSignInEmail({
    required String email,
    required String password}) async {

    AuthResultStatus? signInStatus;
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if(authResult.user != null && authResult.user!.emailVerified)
        signInStatus = AuthResultStatus.successful;

      else if(!(authResult.user!.emailVerified))
        signInStatus = AuthResultStatus.emailNotVerified;

    } on FirebaseException catch (e) {
      print('Exception IN SIGN IN EMAIL: $e');
      signInStatus = AuthExceptionHandler.handleException(e);
    }
    return signInStatus;
  }

  Future<AuthResultStatus?> signInWithGoogle() async {
    AuthResultStatus? signInStatusWithGoogle;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser!
          .authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential);
      signInStatusWithGoogle = AuthResultStatus.successful;
    } catch (e) {
      print('Exception IN SIGN IN GOOGLE: $e');
      signInStatusWithGoogle = AuthExceptionHandler.handleException(e);
    }
    return signInStatusWithGoogle;
  }

  Future<AuthResultStatus?> signUpWithEmailAndPassword(
      {required String email,
        required String password}) async {

    AuthResultStatus? signUpStatus;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((state){
            if (!(state.user!.emailVerified)) {
              state.user!.sendEmailVerification();
              signOut();
            }
            signUpStatus = AuthResultStatus.successful;
          });

    } on FirebaseAuthException catch (e) {
      print('Exception IN SIGN UP EMAIL: $e');
      signUpStatus = AuthExceptionHandler.handleException(e);
    }
    return signUpStatus;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

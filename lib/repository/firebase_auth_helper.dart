import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exception_handler.dart';

class FirebaseAuthHelper {
  final FirebaseAuth auth;
  AuthResultStatus? _status;
  FirebaseAuthHelper(this.auth);

  Future<AuthResultStatus?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(authResult.user != null) {
        _status = AuthResultStatus.successful;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<UserCredential> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

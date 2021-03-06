import 'package:firebase_auth/firebase_auth.dart';

import 'auth_exception_handler.dart';

class FirebaseAuthRepository {
  final FirebaseAuth auth;
  AuthResultStatus _status;
  FirebaseAuthRepository(this.auth);

  Future<AuthResultStatus> signInWithEmailAndPassword({String email, String password}) async {
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

  Future<UserCredential> signUpWithEmailAndPassword({String email, String password}) async {
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

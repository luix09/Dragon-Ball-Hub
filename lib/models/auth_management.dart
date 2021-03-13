import 'package:dragonballhub/repository/auth_exception_handler.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSignInData extends StateNotifier<AuthResultStatus?> {
  final AuthHelper auth;
  String email = "";
  String password = "";
  dynamic error;

  UserSignInData({
    required this.auth,
  }) : super(AuthResultStatus.undefined);

  void resetData() {
    email = "";
    password = "";
  }

  String generateStateMsg() {
    return AuthExceptionHandler.generateExceptionMessage(state);
  }

  Future<AuthResultStatus?> signIn() async {
    try {
      state = await auth.userSignInEmail(
          email: this.email, password: this.password);
      return state;
    } catch (e) {
      error = e;
      rethrow;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

//--------------------------------------------------------------------------------

class UserSignUpData with ChangeNotifier {
  final AuthHelper auth;
  String nome = "";
  String cognome = "";
  DateTime? birthDate = DateTime(2000);
  String email = "";
  String password = "";


  UserSignUpData({
    required this.auth,
  });


  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (!user!.emailVerified) {
      await user.sendEmailVerification();
    }
  }


  Future<void> signUpEmail() async {
    try {
      UserCredential userCredential = await auth.signUpWithEmailAndPassword(
          email: this.email,
          password: this.password
      ).catchError((e) {
        print(e);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

}

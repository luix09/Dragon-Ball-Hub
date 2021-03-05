import 'package:dragonballhub/models/user_field.dart';
import 'package:dragonballhub/repository/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSignInData with ChangeNotifier {
  final FirebaseAuthRepository auth;
  UserField email = UserField();
  UserField password = UserField();
  bool isLoading = false;
  dynamic error;

  static const String errorMinCharactersEmail = "Email must be at least 3 characters";
  static const String emailNotFound = "Email not found";
  static const String invalidEmail = "Invalid email";
  static const String errorMinCharactersPassword =
      "Password must be at least 3 characters";

  UserSignInData({
    @required this.auth,
    email = '',
    password = '',
  });

  bool get isValid {
    if (email.value != null && password.value != null){
      return true;
    } else {
      return false;
    }
  }

  void resetData() {
    email = UserField();
    password = UserField();
    isLoading = false;
  }

  void changeEmail(String value) {
    this.email.setValue(value);
    if (value.length <= 3) {
      this.email.setError(errorMinCharactersEmail);
    } else {
      this.email.setError(null);
    }
    notifyListeners();
  }

  void changePassword(String value) {
    this.password.setValue(value);
    if (value.length <= 3) {
      this.password.setError(errorMinCharactersPassword);
    } else {
      this.password.setError(null);
    }
    notifyListeners();
  }


  Future<User> signIn() async {
    try {
      isLoading = true;
      UserCredential userCredentials = await auth.signInWithEmail(
          email: this.email.value, password: this.password.value);
      return userCredentials?.user;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

//--------------------------------------------------------------------------------

class UserSignUpData with ChangeNotifier {
  final FirebaseAuthRepository auth;
  UserField nome = UserField();
  UserField cognome = UserField();
  DateTime birthDate = DateTime(2000);
  UserField email = UserField();
  UserField password = UserField();


  UserSignUpData({
    @required this.auth,
  });


  Future<void> verifyEmail() async {
    User user = FirebaseAuth.instance.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }


  Future<void> signUpEmail() async {
    try {
      UserCredential userCredential = await auth.signUpWithEmailAndPassword(
          email: this.email.value.toString(),
          password: this.password.value.toString()
      ).catchError((e) {
        print(e);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        this.password.error = "The password is too weak";
      } else if (e.code == 'email-already-in-use') {
        this.email.error = "Email is already taken. Choose a new one.";
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

}

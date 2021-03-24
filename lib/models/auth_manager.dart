import 'package:dragonballhub/models/user_data_model.dart';
import 'package:dragonballhub/repository/auth_exception_handler.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAuth extends StateNotifier<AuthResultStatus?> {
  final AuthHelper authHelper;
  UserDataModel userDataModel = UserDataModel();

  UserAuth({required this.authHelper}) : super(null);

  void resetData() {
    userDataModel.resetData();
  }

  String generateStateMsg(state) {
    return AuthExceptionHandler.generateExceptionMessage(state);
  }

  Future<void> deleteUserAuth(User currentUser) async {
    try {
      print("Sono dentro deleteUserAuth");
      await currentUser.delete()
          .catchError((error) => print("Failed to delete user from auth: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<void> signOut() async {
    await authHelper.signOut();
  }
}

//TODO: generalize these 2 classes in UserAuth ?
class UserSignInData extends StateNotifier<AuthResultStatus?> {
  UserAuth userAuth;

  UserSignInData({
    required this.userAuth,
  }) : super(AuthResultStatus.undefined);

  String generateStateMsg() {
    return userAuth.generateStateMsg(state);
  }

  Future<AuthResultStatus?> signInWithGoogle() async {
    try {
      state = await userAuth.authHelper.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
    return state;
  }

  Future<AuthResultStatus?> signInEmail() async {
    try {
      final auth = userAuth.authHelper;
      final userData = userAuth.userDataModel;

      state = await auth.userSignInEmail(
          email: userData.email, password: userData.password);
      return state;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await userAuth.signOut();
  }
}

//--------------------------------------------------------------------------------

class UserSignUpData extends StateNotifier<AuthResultStatus?> {
  UserAuth userAuth;

  UserSignUpData({
    required this.userAuth,
  }) : super(AuthResultStatus.undefined);

  String generateStateMsg() {
    return userAuth.generateStateMsg(state);
  }

  Future<AuthResultStatus?> signUpEmail() async {
    try {
      final auth = userAuth.authHelper;
      final userData = userAuth.userDataModel;

      state = await auth.signUpWithEmailAndPassword(
          email: userData.email, password: userData.password);
      return state;
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return state;
  }

  Future<void> signOut() async {
    await userAuth.signOut();
  }
}

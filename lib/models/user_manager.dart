import 'package:dragonballhub/models/user_data_model.dart';
import 'package:dragonballhub/repository/firestore_cloud_helper.dart';
import 'package:dragonballhub/repository/user_exception_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_manager.dart';

class UserManager extends StateNotifier<UserManagerStatus> {
  FirestoreCloudHelper firestoreHelper;
  UserAuth userAuth;
  UserDataModel userDataModel;

  UserManager(
      {required this.firestoreHelper,
      required this.userDataModel,
      required this.userAuth})
      : super(UserManagerStatus.undefined);

  Future<UserManagerStatus>? addUser() async {
    try {
      final uid = firestoreHelper.auth.currentUser!.uid;
      firestoreHelper.addUser(userDataModel.nome, userDataModel.cognome,
          userDataModel.birthDate, uid)!
          .whenComplete(() => state = UserManagerStatus.UserAdded)
          .catchError((error) => state = UserManagerStatus.undefined);
    } catch (e) {
      print("Exception in addUser USERMANAGER: $e");
    }
    return state;
  }

  Future<UserManagerStatus> deleteUser() async {
    try {
      final uid = firestoreHelper.auth.currentUser!.uid;
      await firestoreHelper.deleteUser(uid);
      await userAuth.deleteUserAuth()
          .catchError((error) => print("Failed to delete user from auth: $error"));
      state = UserManagerStatus.UserAdded;
    } catch (e) {
      print("Exception in deleteUser: $e");
    }
    return state;
  }
}

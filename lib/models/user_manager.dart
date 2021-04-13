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
      await firestoreHelper
          .addUser(
              name: userDataModel.nome,
              surname: userDataModel.cognome,
              birthDate: userDataModel.birthDate)!
          .whenComplete(() => state = UserManagerStatus.UserAdded)
          .catchError((error) => state = UserManagerStatus.undefined);
    } catch (e) {
      rethrow;
    }
    return state;
  }

  Future<UserManagerStatus> deleteUserFromFirestore() async {
    try {
      final uid = userAuth.authHelper.auth.currentUser!.uid;
      await firestoreHelper.deleteUser(uid);
      state = UserManagerStatus.UserDeleted;
    } catch (e) {
      print("Exception in deleteUser UserManager: $e");
      state = UserManagerStatus.undefined;
    }
    return state;
  }
}

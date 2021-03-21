import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:dragonballhub/repository/user_exception_handler.dart';

class FirestoreCloudHelper {
  static const String userCollections = 'users';
  CollectionReference users =
      FirebaseFirestore.instance.collection(userCollections);
  final AuthHelper authHelper;

  FirestoreCloudHelper(this.authHelper);

  Future<UserManagerStatus>? addUser(
      {required String name,
      required String surname,
      required DateTime? birthDate}) async {

    UserManagerStatus userStatus = UserManagerStatus.undefined;
    try {
      final uid = authHelper.auth.currentUser!.uid;
      await users.doc(uid).set({
        'name': name,
        'surname': surname,
        'birthDate': birthDate,
      }).whenComplete(() => userStatus = UserManagerStatus.UserAdded);

    } catch (e) {
      print("Exception in addUser: $e");
      userStatus = UserManagerFeedback.handleException(e);
    }
    return userStatus;
  }

  Future<UserManagerStatus> deleteUser(String uid) async {
    UserManagerStatus userStatus = UserManagerStatus.undefined;
    try {
      users
          .doc(uid)
          .delete()
          .whenComplete(() => userStatus = UserManagerStatus.UserDeleted);
          //.catchError((error) => print("Failed to delete user: $error"));
    } catch (e) {
      print("Exception in deleteUser: $e");
      userStatus = UserManagerFeedback.handleException(e);
    }
    return userStatus;
  }
}

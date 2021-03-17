import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreCloudHelper {
  static const String userCollections = 'users';
  CollectionReference users =
      FirebaseFirestore.instance.collection(userCollections);
  final FirebaseAuth auth;

  FirestoreCloudHelper(this.auth);

  Future<void>? addUser(
      String name, String surname, DateTime? birthDate, String uid) {
    try {
      return users
          .doc(uid)
          .set({
            'name': name,
            'surname': surname,
            'birthDate': birthDate,
          });
    } catch (e) {
      print("Exception in addUser: $e");
      rethrow;
    }
  }

  Future<void> deleteUser(String uid) {
    try {
      return users
          .doc(uid)
          .delete()
          .then((value) => print("User Deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    } catch (e) {
      print("Exception in deleteUser: $e");
      rethrow;
    }
  }
}

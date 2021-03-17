import 'package:dragonballhub/models/user_data_model.dart';
import 'package:dragonballhub/repository/firestore_cloud_helper.dart';
import 'package:dragonballhub/repository/user_exception_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class UserManager extends StateNotifier<UserManagerStatus> {
  FirestoreCloudHelper? firestoreHelper;
  UserDataModel? userDataModel;
  UserManager({this.firestoreHelper, this.userDataModel}) : super(UserManagerStatus.undefined);

  Future<UserManagerStatus>? addUser() {
    try {
      final uid = firestoreHelper!.auth.currentUser!.uid;
      firestoreHelper!.addUser(userDataModel!.nome, userDataModel!.cognome, userDataModel!.birthDate, uid);
      state = UserManagerStatus.UserAdded;
    } catch(e) {
      print("Exception in addUser: $e");
    }
  }
}
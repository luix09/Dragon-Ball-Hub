import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragonballhub/models/auth_manager.dart';
import 'package:dragonballhub/models/user_manager.dart';
import 'package:dragonballhub/repository/auth_helper.dart';
import 'package:dragonballhub/repository/firestore_cloud_helper.dart';
import 'package:dragonballhub/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ProviderFamily<List<String>, dynamic>? listProvider = Provider.family((ref, dynamic fakeSize) {
  return List<String>.generate(fakeSize, (i) => "Item $i");
});

final firebaseAuthProvider = Provider<FirebaseAuth>(
        (ref) => FirebaseAuth.instance
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final loginProvider = StateNotifierProvider<UserSignInData>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userSignIn = UserSignInData(auth: AuthHelper(auth: authInstance));
  return userSignIn;
});

final registrationProvider = StateNotifierProvider<UserSignUpData>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userSignUp = UserSignUpData(auth: AuthHelper(auth: authInstance));
  return userSignUp;
});

final userCloudProvider = StateNotifierProvider<UserManager>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userDataProvider = ref.watch(userSignUpModel);
  final cloud = UserManager(
      firestoreHelper: FirestoreCloudHelper(authInstance),
      userDataModel: userDataProvider);

  return cloud;
});
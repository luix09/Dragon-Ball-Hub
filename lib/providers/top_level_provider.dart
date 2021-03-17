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

// It provides access to Firestore Auth
final userAuthProvider = StateNotifierProvider<UserAuth>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);

  final userAuth = UserAuth(
      authHelper: AuthHelper(auth: authInstance));
  return userAuth;
});

// It provides access to Firestore Cloud
final userCloudProvider = StateNotifierProvider<UserManager>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userDataProvider = ref.watch(userSignUpModel);
  final userAuth = ref.watch(userAuthProvider);

  final cloud = UserManager(
      firestoreHelper: FirestoreCloudHelper(authInstance),
      userAuth: userAuth,
      userDataModel: userDataProvider);

  return cloud;
});

final loginProvider = StateNotifierProvider<UserSignInData>((ref) {
  final userAuth = ref.watch(userAuthProvider);

  final userSignIn = UserSignInData(userAuth: userAuth);
  return userSignIn;
});

final registrationProvider = StateNotifierProvider<UserSignUpData>((ref) {
  final userAuth = ref.watch(userAuthProvider);

  final userSignUp = UserSignUpData(userAuth: userAuth);
  return userSignUp;
});

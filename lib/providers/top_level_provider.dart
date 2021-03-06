import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';

final ProviderFamily<List<String>, dynamic>? listProvider = Provider.family((ref, dynamic fakeSize) {
  return List<String>.generate(fakeSize, (i) => "Item $i");
});

final firebaseAuthProvider = Provider<FirebaseAuth>(
        (ref) => FirebaseAuth.instance
);

final authStateChangesProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges()
);

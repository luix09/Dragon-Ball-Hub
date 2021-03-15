import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationWidget extends ConsumerWidget {
  const AuthenticationWidget({
    Key? key,
    required this.signedInBuilder,
    required this.nonSignedInBuilder,
  }) : super(key: key);

  final WidgetBuilder signedInBuilder;
  final WidgetBuilder nonSignedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user){
        return SafeArea(child: _data(context, user, watch));
        },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Center(
          child: Text("Something went wrong!"),
        )
      ),
    );
  }

  Widget _data(BuildContext context, User? user, ScopedReader watch) {
    if (user != null) {
      if(!(user.emailVerified)) {
        final authData = watch(loginProvider);
        authData.signOut();
      }
      return signedInBuilder(context);
    }
    return nonSignedInBuilder(context);
  }
}
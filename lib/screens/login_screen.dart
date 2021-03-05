import 'package:dragonballhub/custom_widgets/dart/login_widgets.dart';
import 'package:dragonballhub/models/auth_management.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/firebase_authentication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:google_fonts/google_fonts.dart';

final loginProvider = Provider<UserSignInData>((ref) {
  final authInstance = ref.watch(firebaseAuthProvider);
  final userSignIn = UserSignInData(auth: FirebaseAuthRepository(authInstance));
  return userSignIn;
});

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          errorText: context.read(loginProvider).email.error,
          border:
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))
      ),
      onChanged: (String value) {
        context.read(loginProvider).changeEmail(value);
      },
    );

    final passwordField = TextField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          errorText: context.read(loginProvider).password.error,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      onChanged: (String value) {
        context.read(loginProvider).changePassword(value);
      },
    );

    final loginButton = Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xFFFF7D45),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            final user = context.read(loginProvider);
            await user.signIn();
            if(user.auth.auth.currentUser != null) {
              Navigator.pop(context);
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17
            ),
          ),
        ));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.orange, Colors.deepOrange]
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TopCenterLogo(),
                SizedBox(height: 70),
                Material(
                  elevation: 7.0,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    child: Column(
                      children: [
                        emailField,
                        SizedBox(height: 20),
                        passwordField,
                        SizedBox(height: 20),
                        loginButton,
                        SizedBox(height: 15),
                        RegisterTextButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}

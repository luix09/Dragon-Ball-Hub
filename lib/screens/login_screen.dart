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
          fillColor: Colors.orangeAccent,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          errorText: context.read(loginProvider).email.error,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
        color: Colors.orange,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            final user = context.read(loginProvider);
            user.signIn();
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
          ),
        ));

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFB0451A),
        body: Container(
          padding: EdgeInsets.all(36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                        child: Image.asset("res/sfera-4.png"),
                      height: 90,
                    ),
                    Text(
                      "DragonBall Hub",
                      style: GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                                color: Colors.amber,
                                blurRadius: 2,
                                offset: Offset(1, 1))
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
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
      );
  }
}

class RegisterTextButton extends StatelessWidget {
  final String registerText = "Non hai un account? Registrati!";

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: Colors.orangeAccent);
    return RichText(
      text: TextSpan(
          text: registerText,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, "/register");
            }),
    );
  }
}

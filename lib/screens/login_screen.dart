import 'package:dragonballhub/custom_widgets/dart/login_widgets.dart';
import 'package:dragonballhub/models/auth_management.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
          padding: const EdgeInsets.all(29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopCenterLogo(),
              SizedBox(height: 45),
              Material(
                elevation: 7.0,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  child: FormWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final _formKey = GlobalKey<FormState>();
  static const String tooShortEmail = "Email is too short";
  static const String errorMinCharactersPassword =
      "Password must be at least 6 characters";

  // TODO: modify validation
  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Cannot be empty';
    } else if (email.length < 4) {
      return tooShortEmail;
    }
    return null;
  }

  // TODO: modify validation
  String? _validatePassword(String password) {
    if (password.isEmpty) {
      return 'Cannot be empty';
    } else if (password.length < 6) {
      return errorMinCharactersPassword;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              validator: (value) => _validateEmail(value!),
              onChanged: (value) =>
              context
                  .read(loginProvider)
                  .email
                  .value = value,
              decoration: new InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Email")
          ),
          SizedBox(height: 25),
          TextFormField(
            obscureText: true,
            validator: (value) => _validatePassword(value!),
            onChanged: (value) =>
            context
                .read(loginProvider)
                .password
                .value = value,
            decoration: new InputDecoration(
              icon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))
                ),
                contentPadding:
                EdgeInsets.only(left: 15, bottom: 10, top: 10, right: 15),
                hintText: "Password"),
          ),
          SizedBox(height: 10),
          Align(
              alignment: Alignment.centerRight,
              child: ForgotPasswordButton()),
          SizedBox(height: 40),
          LoginButtonWidget(_formKey),
          SizedBox(height: 10),
          RegisterTextButton(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}


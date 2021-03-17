import 'package:auth_buttons/res/shared/auth_style.dart';
import 'package:dragonballhub/custom_widgets/dart/login_widgets.dart';
import 'package:dragonballhub/models/user_data_model.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auth_buttons/auth_buttons.dart'
    show GoogleAuthButton, FacebookAuthButton, AuthButtonStyle;


final userModel = Provider<UserDataModel>((ref) {
  final signInProvider = ref.watch(loginProvider);
  return signInProvider.userAuth.userDataModel;
}
);

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
          padding: EdgeInsets.all(SizeConfig.imageSizeMultiplier * 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopCenterBallLogo(),
              SizedBox(height: SizeConfig.heightMultiplier * 5),
              Material(
                elevation: 7.0,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30, horizontal: 20),
                  child: LoginFormWidget(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {

  final _formKey = GlobalKey<FormState>();
  static const String tooShortEmail = "Email is too short";
  static const String errorMinCharactersPassword =
      "Password must be at least 6 characters";
  bool _showPassword = false;

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
                  .read(userModel)
                  .email = value,
              decoration: new InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Email")
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 3.5),
          TextFormField(
            obscureText: !_showPassword,
            validator: (value) => _validatePassword(value!),
            onChanged: (value) =>
            context
                .read(userModel)
                .password= value,
            decoration: new InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off
                ),
              ),
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
          SizedBox(height: SizeConfig.heightMultiplier * 3.5),
          LoginButtonWidget(_formKey),
          SizedBox(height: 15),
          RegisterTextButton(),
          SizedBox(height: 20),
          SocialDivider(),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GoogleAuthButton(
                onPressed: () {},
                darkMode: false,
                style: AuthButtonStyle.icon,
                iconSize: SizeConfig.imageSizeMultiplier * 6,
                height: SizeConfig.heightMultiplier * 6,
                width: SizeConfig.heightMultiplier * 6,
              ),
              SizedBox(width: 10),
              FacebookAuthButton(
                onPressed: () {},
                darkMode: false,
                style: AuthButtonStyle.icon,
                iconSize: SizeConfig.imageSizeMultiplier * 6,
                height: SizeConfig.heightMultiplier * 6,
                width: SizeConfig.heightMultiplier * 6,
              ),
            ],
          )
        ],
      ),
    );
  }
}


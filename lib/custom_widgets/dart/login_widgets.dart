import 'package:dragonballhub/repository/auth_exception_handler.dart';
import 'package:dragonballhub/screens/login_screen.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopCenterBallLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Column(
        children: [
          Container(
            child: Image.asset("res/sfera-4.png"),
            height: SizeConfig.imageSizeMultiplier * 22.5,
          ),
          Text(
            "DragonBall Hub",
            style: GoogleFonts.nunito(
                fontSize: SizeConfig.textMultiplier * 4,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                      color: Colors.amber, blurRadius: 3, offset: Offset(1, 1))
                ]),
          ),
        ],
      ))
    ]);
  }
}

class LoginButtonWidget extends StatelessWidget {
  LoginButtonWidget(this.formKey);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0xFFFF7D45),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () async {
            if(formKey.currentState!.validate()) {
              final user = context.read(loginProvider);
              AuthResultStatus? status = await user.signIn();
              if(status == AuthResultStatus.successful) {
                Navigator.pop(context);
              }
              else {
                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(SnackBar(content: Text('${AuthExceptionHandler.generateExceptionMessage(status)}')));
              }
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
  }
}


class RegisterTextButton extends StatelessWidget {
  final String registerText = "Non hai un account? Registrati!";

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(color: const Color(0xFFFF7D45));
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

class ForgotPasswordButton extends StatelessWidget {
  final String forgotPassText = "Hai dimenticato la password?";

  @override
  Widget build(BuildContext context) {
    TextStyle linkStyle = TextStyle(
        fontSize: 12,
        color: const Color(0xFFFFAD88)
    );
    return RichText(
      text: TextSpan(
          text: forgotPassText,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, "/forgot_password");
            }),
    );
  }
}

class SocialDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 8.0,
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          'OR',
          style: TextStyle(color: Colors.black),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
            height: 8.0,
          ),
        )
      ],
    );
  }
}


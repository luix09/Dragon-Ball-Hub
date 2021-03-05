import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCenterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Column(
        children: [
          Container(
            child: Image.asset("res/sfera-4.png"),
            height: 90,
          ),
          Text(
            "DragonBall Hub",
            style: GoogleFonts.nunito(
                fontSize: 23,
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopCenterGokuLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Column(
            children: [
              Container(
                child: Image.asset("res/goku-greeting.png"),
                height: 100,
              ),
              Text(
                "Piacere di conoscerti!",
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

class SignUpButtonWidget extends StatelessWidget {
  SignUpButtonWidget(this.formKey);
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

          },
          child: Text(
            "Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17
            ),
          ),
        ));
  }
}
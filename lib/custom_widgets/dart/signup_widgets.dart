import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/repository/auth_exception_handler.dart';
import 'package:dragonballhub/repository/user_exception_handler.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopCenterGokuLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          child: Column(
        children: [
          Container(
            child: Image.asset("res/goku-greeting.png"),
            height: SizeConfig.imageSizeMultiplier * 20,
          ),
          Text(
            "Piacere di conoscerti!",
            style: GoogleFonts.nunito(
                fontSize: SizeConfig.textMultiplier * 3.5,
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
  SignUpButtonWidget(this.formKey, this.showDialog);

  final GlobalKey<FormState> formKey;
  final Future<void> Function(DialogFeedback) showDialog;

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
            if (formKey.currentState!.validate()) {
              final userAuth = context.read(registrationProvider);
              final userManager = context.read(userCloudProvider);
              final authStatus = await userAuth.signUpEmail();
              //print("authstatuschange BEFORE: ${authStatusChange.data!.value}");

              if(authStatus != AuthResultStatus.successful) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${userAuth.generateStateMsg()}')));
              } else {
                //print("authstatuschange AFTER SUCCESS: ${authStatusChange.data!.value}");

                await userManager.addUser()!.then((value) async {
                  DialogFeedback feedback = UserManagerFeedback.generateDialogMessage(value);

                  if (value != UserManagerStatus.UserAdded) {
                    await showDialog(feedback);
                    await userManager.deleteUserFromFirestore();
                  } else {
                    feedback = UserManagerFeedback.generateDialogMessage(value);
                    await showDialog(feedback).whenComplete(() => userAuth.signOut());
                    Navigator.pop(context);
                  }
              });
            }
          }},
          child: Text(
            "Sign up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: SizeConfig.textMultiplier * 2.5),
          ),
        ));
  }
}

import 'package:dragonballhub/screens/sign_in_screen.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreLoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            BackgroundWidget(),
            Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 2, child: Container()),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: SizeConfig.heightMultiplier * 15,
                      child: Center(child: Image.asset("res/sfera_4.png")),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "Welcome to DragonBall Hub",
                        style: GoogleFonts.nunito(
                            letterSpacing: 0,
                            fontSize: SizeConfig.textMultiplier * 3.5,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.amber,
                                  blurRadius: 0,
                                  offset: Offset(1.2, 1))
                            ]),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MyBlinkingButton(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('res/background_prelogin-min.jpg'),
              fit: BoxFit.fill),
        ),
      ),
      Container(
        color: Color.fromRGBO(165, 165, 165, 0.55),
      )
    ]);
  }
}

class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IconButton(
          iconSize: SizeConfig.heightMultiplier * 8,
          icon: Icon(
            Icons.arrow_downward,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          }),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

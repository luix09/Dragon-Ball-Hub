import 'package:dragonballhub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreLoginScreen extends StatelessWidget {


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          BackgroundWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Container(
                child: Center(child: Image.asset("res/sfera-4.png")),
              ),
              SizedBox(height: 15),
              Container(
                child: Text(
                  "Welcome to DragonBall Hub",
                  style: GoogleFonts.abel(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      shadows: [
                        Shadow(
                            color: Colors.amber,
                            blurRadius: 2,
                            offset: Offset(1, 1))
                      ]),
                ),
              ),
              SizedBox(height: 25),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.bottomCenter,
                child: MyBlinkingButton(),
              ),
              SizedBox(height: 35),
            ],
          )
        ],
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('res/background_prelogin.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            color: Color.fromRGBO(200, 200, 200, 0.60),
          )
        ]
    );
  }
}


class MyBlinkingButton extends StatefulWidget {
  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IconButton(
          iconSize: 50,
          icon: Icon(Icons.arrow_downward,),
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

      var tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

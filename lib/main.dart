import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dragonballhub/authentication_widget.dart';
import 'package:dragonballhub/screens/forgot_password.dart';
import 'package:dragonballhub/screens/home_screen.dart';
import 'package:dragonballhub/screens/no_internet_screen.dart';
import 'package:dragonballhub/screens/pre_login_screen.dart';
import 'package:dragonballhub/screens/sign_up_screen.dart';
import 'package:dragonballhub/screens/settings_screen.dart';
import 'package:dragonballhub/themedata.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // ProviderScope is where the state of our providers will be stored.
  runApp(ProviderScope(observers: [Logger()], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) =>
            OrientationBuilder(builder: (context, orientation) {
              SizeConfig.init(constraints, orientation);

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: buildTheme(),
                title: 'Dragon Ball Hub',
                initialRoute: '/start',
                routes: {
                  '/start': (context) => AuthenticationWidget(
                        nonSignedInBuilder: (context) => PreLoginScreen(),
                        signedInBuilder: (context) => HomeScreen(),
                      ),
                  '/settings': (context) => SettingsScreen(),
                  "/register": (context) => RegisterScreen(),
                  "/forgot_password": (context) => ForgotPassword(),
                }
              );
            }));
  }
}

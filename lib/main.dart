import 'package:dragonballhub/authentication_widget.dart';
import 'package:dragonballhub/screens/home_screen.dart';
import 'package:dragonballhub/screens/pre_login_screen.dart';
import 'package:dragonballhub/screens/register_screen.dart';
import 'package:dragonballhub/screens/settings_screen.dart';
import 'package:dragonballhub/themedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  // ProviderScope is where the state of our providers will be stored.
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      },
    );
  }
}
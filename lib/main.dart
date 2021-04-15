import 'package:dragonballhub/authentication_widget.dart';
import 'package:dragonballhub/screens/forgot_password.dart';
import 'package:dragonballhub/screens/gallery_screen.dart';
import 'package:dragonballhub/screens/news_screen.dart';
import 'package:dragonballhub/screens/pre_login_screen.dart';
import 'package:dragonballhub/screens/profile_screen.dart';
import 'package:dragonballhub/screens/search_news_page.dart';
import 'package:dragonballhub/screens/sign_up_screen.dart';
import 'package:dragonballhub/screens/settings_screen.dart';
import 'package:dragonballhub/screens/wiki_screen.dart';
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
  late String title;

  @override
  void initState() {
    title = "DragonBall Hub";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("res/sfera_4.png"), context);
    precacheImage(AssetImage("res/background_prelogin-min.jpg"), context);
    precacheImage(AssetImage("res/logo-dragonballz.png"), context);
    precacheImage(AssetImage("res/goku-greeting.png"), context);
    return LayoutBuilder(
        builder: (context, constraints) =>
            OrientationBuilder(builder: (context, orientation) {
              SizeConfig.init(constraints, orientation);

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: buildTheme(),
                title: title,
                initialRoute: '/start',
                routes: {
                  '/start': (context) => AuthenticationWidget(
                        nonSignedInBuilder: (context) => PreLoginScreen(),
                        signedInBuilder: (context) {
                          return NewsScreen();
                        }),
                  SettingsScreen.id: (context) => SettingsScreen(),
                  RegisterScreen.id: (context) => RegisterScreen(),
                  ForgotPassword.id: (context) => ForgotPassword(),
                  NewsScreen.id: (context) => NewsScreen(),
                  SearchNewsPage.id: (context) => SearchNewsPage(hintText: "Search news"),
                  WikiScreen.id: (context) => WikiScreen(),
                  GalleryScreen.id: (context) => GalleryScreen(),
                  ProfileScreen.id: (context) => ProfileScreen(),
                }
              );
            }));
  }
}

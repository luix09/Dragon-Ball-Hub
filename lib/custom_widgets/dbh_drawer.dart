import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/screens/gallery_screen.dart';
import 'package:dragonballhub/screens/news_screen.dart';
import 'package:dragonballhub/screens/profile_screen.dart';
import 'package:dragonballhub/screens/settings_screen.dart';
import 'package:dragonballhub/screens/wiki_screen.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuEntry {
  String name;
  Icon icon;
  String route;

  MenuEntry({required this.name, required this.icon, required this.route});
}

class DbhDrawer extends StatelessWidget {
  final List<MenuEntry> menuElements = [
    MenuEntry(
        name: "News",
        icon: Icon(Icons.new_releases_sharp),
        route: NewsScreen.id),
    MenuEntry(
        name: "Wiki",
        icon: Icon(Icons.library_books_rounded),
        route: WikiScreen.id),
    MenuEntry(
        name: "Gallery",
        icon: Icon(Icons.video_collection_rounded),
        route: GalleryScreen.id),
    MenuEntry(
        name: "Profile",
        icon: Icon(Icons.person),
        route: ProfileScreen.id),
    MenuEntry(
        name: "Settings",
        icon: Icon(Icons.settings),
        route: SettingsScreen.id),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "res/sfera_4.png",
                      height: SizeConfig.imageSizeMultiplier * 12,
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      "DragonBall Hub",
                      style: GoogleFonts.nunito(
                          letterSpacing: 0,
                          fontSize: SizeConfig.textMultiplier * 1.9,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Colors.amber,
                                blurRadius: 0,
                                offset: Offset(1.2, 1))
                          ]),
                    ),
                    Text("v1.0.0"),
                    SizedBox(height: SizeConfig.heightMultiplier),
                    Divider(),
                  ],
                ),
              ),
            Flexible(
              flex: 4,
              child: Container(
                  child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: menuElements[index].icon,
                    title: Text(
                      menuElements[index].name,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.2,
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, menuElements[index].route);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: menuElements.length,
                padding: EdgeInsets.zero,
              )),
            ),
            IconButton(
                icon: Icon(
                  Icons.logout,
                  size: SizeConfig.heightMultiplier * 4,
                ),
                onPressed: () {
                  context.read(userAuthProvider).signOut();
                })
          ],
        ),
      ),
    );
  }
}

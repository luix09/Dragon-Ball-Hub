import 'package:dragonballhub/screens/gallery_screen.dart';
import 'package:dragonballhub/screens/news_screen.dart';
import 'package:dragonballhub/screens/settings_screen.dart';
import 'package:dragonballhub/screens/wiki_screen.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuEntry {
  String name;
  Icon icon;
  String? route;

  MenuEntry({required this.name, required this.icon, this.route});
}

class DbhDrawer extends StatelessWidget {
  final List<MenuEntry> menuElements = [
    MenuEntry(
        name: "NEWS",
        icon: Icon(Icons.new_releases_sharp, color: Colors.white),
        route: NewsScreen.id),
    MenuEntry(
        name: "WIKI",
        icon: Icon(Icons.library_books_rounded, color: Colors.white),
        route: WikiScreen.id),
    MenuEntry(
        name: "GALLERY",
        icon: Icon(Icons.video_collection_rounded, color: Colors.white,),
        route: GalleryScreen.id),
    MenuEntry(
        name: "SETTINGS",
        icon: Icon(Icons.settings, color: Colors.white),
        route: SettingsScreen.id),
    MenuEntry(
        name: "LOGOUT",
        icon: Icon(Icons.logout, color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFFF8A00),
        padding: EdgeInsets.symmetric(vertical: 5),
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("v1.0.0", style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w300
                    )),
                    Center(
                      child: Image.asset(
                          "res/sfera_4.png",
                          width: SizeConfig.imageSizeMultiplier * 12,
                        ),
                    ),
                    IconButton(onPressed: (){}, icon: Icon(Icons.close))
                  ],
                ),
              ),
            SizedBox(height: SizeConfig.heightMultiplier * 4.5,),
            Flexible(
              flex: 4,
              child: Container(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      color: Color(0xFFEE8100),
                      child: ListTile(
                        trailing: menuElements[index].icon,
                        title: Text(
                          menuElements[index].name,
                          style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.2,
                            color: Colors.white
                          ),
                        ),
                        dense: true,
                        onTap: () {
                          Navigator.popAndPushNamed(context, menuElements[index].route!);
                        },
                      ),
                    ),
                  );
                },
                itemCount: menuElements.length,
                padding: EdgeInsets.zero,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:dragonballhub/custom_widgets/dbh_drawer.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';

class WikiScreen extends StatefulWidget {
  static const String id = "/wiki_screen";

  @override
  _WikiScreenState createState() => _WikiScreenState();
}

class _WikiScreenState extends State<WikiScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: DbhDrawer(),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(color: Color(0xFFFF8A00)),
            child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
              SliverToBoxAdapter(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 50,
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        child: Image.asset(
                          "res/wiki_image.png",
                          fit: BoxFit.fill,
                          color: Color.fromRGBO(240, 240, 240, 0.8),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 20,
                          child: Text(
                            "Wiki",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 4,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(delegate: SliverChildListDelegate([WikiDashboard()])),
            ]),
          )),
    );
  }
}

class MenuEntryWidget extends StatelessWidget {
  final String title;

  MenuEntryWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Material(
        borderRadius: BorderRadius.circular(20),
        type: MaterialType.button,
        color: Color(0xFFe85300),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 10),
          child: Container(
            color: Color(0xe85300),
            child: Row(
              children: [
                SizedBox(width: SizeConfig.widthMultiplier * 2),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 3),
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WikiDashboard extends StatelessWidget {
  final List<String> menuEntry = [
    "LISTA PERSONAGGI",
    "MANGA",
    "ANIME",
    "VIDEOGIOCHI",
    "FILM"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
      child: Material(
        elevation: 25.0,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: menuEntry.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: MenuEntryWidget(title: menuEntry[index])
                );
              }),
        ),
      ),
    );
  }
}

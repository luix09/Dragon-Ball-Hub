import 'package:dragonballhub/custom_widgets/dbh_drawer.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  static const String id = "/gallery_screen";

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: DbhDrawer(),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(color: Color(0xFFFF8A00)),
            child: CustomScrollView(
                slivers: [
              SliverToBoxAdapter(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 50,
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        child: Image.asset(
                          "res/gallery_image.jpg",
                          fit: BoxFit.fill,
                          color: Color.fromRGBO(240, 240, 240, 0.8),
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 20,
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 4,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          )),
                    ],
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Padding(
                    child: GalleryDashboard(),
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
              ])),
            ]),
          )),
    );
  }
}

class MediaEntryWidget extends StatelessWidget {
  final String title;
  final String image;

  MediaEntryWidget({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(13),
        type: MaterialType.button,
        color: Color(0xFFe85300),
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0),
          child: Container(
            height: SizeConfig.heightMultiplier * 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(children: <Widget>[
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                      width: SizeConfig.widthMultiplier * 100,
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text(
                      title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class GalleryDashboard extends StatelessWidget {
  final List<String> menuEntry = ["ANIME", "MANGA"];

  final List<String> images = ["res/anime-db.jpg", "res/manga-db.jpg"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 70,
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
                    child: MediaEntryWidget(
                      title: menuEntry[index],
                      image: images[index],
                    ));
              }),
        ),
      ),
    );
  }
}

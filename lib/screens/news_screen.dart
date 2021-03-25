import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragonballhub/custom_widgets/dbh_drawer.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsContainer extends StatefulWidget {
  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DbhDrawer(),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.orange, Colors.deepOrange])),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              title: Image.asset(
                "res/sfera-4.png",
                height: 50,
              ),
              actions: [
                IconButton(icon: Icon(Icons.person), onPressed: () {}),
              ],
              centerTitle: true,
              floating: false,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    NewsDashboard(),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsDashboard extends StatefulWidget {
  @override
  _NewsDashboardState createState() => _NewsDashboardState();
}

class _NewsDashboardState extends State<NewsDashboard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        elevation: 15.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: 20),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                title: Text(
                  "Recent News",
                  style: GoogleFonts.nunito(
                      letterSpacing: 0,
                      fontSize: SizeConfig.textMultiplier * 3.2,
                      fontWeight: FontWeight.w100,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.search, color: Colors.black,),
                  onPressed: (){
                  },
                ),
              ),
              SizedBox(height: 20,),
              CarouselSlider(
                options: CarouselOptions(
                  height: SizeConfig.heightMultiplier * 30,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 7),
                  autoPlayAnimationDuration: Duration(milliseconds: 1700),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  //onPageChanged: (value, ) {},
                  scrollDirection: Axis.horizontal,
                ),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: SizeConfig.heightMultiplier * 50,
                                //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  /*boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(0.0, 4.0),
                                        blurRadius: 15.0,
                                        spreadRadius: -1),
                                  ],*/
                                ),
                                child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image(
                                              image: AssetImage("res/background2.jpg"),
                                              height: SizeConfig.imageSizeMultiplier * 100,
                                              width: SizeConfig.imageSizeMultiplier * 100,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                      ),
                                      Wrap(
                                        children: <Widget>[
                                          Container(
                                            height: SizeConfig.heightMultiplier * 10,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 15,
                                                  left: 20,
                                                  child: Text(
                                                    "Happy Birthday!",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig.textMultiplier * 2,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.deepOrange),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 15,
                                                  left: 20,
                                                  child: Text(
                                                    "Dragon Ball Super is now 3 years old today.\nIt has been 3 years since its last episode.",
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontStyle: FontStyle.italic,
                                                        fontSize: SizeConfig.textMultiplier * 1.3),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                              ),
                            ),
                          ],
                        );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Divider(
                thickness: 1.4,
              ),
              SizedBox(height: 10),
              DefaultTabController(
                length: 4,
                child: SizedBox(
                  height: SizeConfig.heightMultiplier * 100,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        labelColor: Colors.black,
                        labelStyle: GoogleFonts.nunito(
                          letterSpacing: 0,
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: <Widget>[
                          Tab(
                            text: "Manga",
                          ),
                          Tab(
                            text: "Anime",
                          ),
                          Tab(
                            text: "Videogames",
                          ),
                          Tab(
                            text: "Brand",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              color: Colors.green,
                              height: 500,
                            ),
                            Container(
                              color: Colors.yellow,
                            ),
                            Container(
                              color: Colors.red,
                            ),
                            Container(
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}


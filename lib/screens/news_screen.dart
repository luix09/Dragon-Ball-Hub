import 'package:carousel_slider/carousel_slider.dart';
import 'package:dragonballhub/custom_widgets/dbh_drawer.dart';
import 'package:dragonballhub/custom_widgets/news_widgets.dart';
import 'package:dragonballhub/models/news_gateway.dart';
import 'package:dragonballhub/models/news_model.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  static const String id = "/news_screen";
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
          shrinkWrap: false,
          slivers: [
            SliverAppBar(
              toolbarHeight: SizeConfig.heightMultiplier * 8,
              //collapsedHeight: SizeConfig.heightMultiplier * 8,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "res/logo-dragonballz.png",
                  height: SizeConfig.heightMultiplier * 10,
                ),
              ),
              actions: [
                ProfilePictureAvatar(),
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
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 25.0,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20, horizontal: 20),
          child: Column(
            children: [
              WelcomeBackWidget(height: SizeConfig.heightMultiplier * 17),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: [
                    Text(
                      "Recent News",
                      style: GoogleFonts.nunito(
                        letterSpacing: 0,
                        fontSize: SizeConfig.textMultiplier * 3.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.black, size: SizeConfig.imageSizeMultiplier * 4,),
                      onPressed: (){
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
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
                                  borderRadius: BorderRadius.circular(8.0),
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Text(
                      "All News",
                      style: GoogleFonts.nunito(
                        letterSpacing: 0,
                        fontSize: SizeConfig.textMultiplier * 3.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Consumer(
                builder: (context, watch, child) => DefaultTabController(
                  length: 5,
                  child: SizedBox(
                    height: SizeConfig.heightMultiplier * 80,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          labelColor: Colors.deepOrange,
                          isScrollable: true,
                          indicatorColor: Colors.deepOrangeAccent,
                          unselectedLabelColor: Colors.black.withOpacity(0.3),
                          labelStyle: GoogleFonts.nunito(
                            letterSpacing: 0,
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: <Widget>[
                            Tab(
                              text: "Dragon Ball Super",
                            ),
                            Tab(
                              text: "Dragon Ball Z",
                            ),
                            Tab(
                              text: "Dragon Ball",
                            ),
                            Tab(
                              text: "Videogames",
                            ),
                            Tab(
                              text: "Extra",
                            )
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: FutureBuilder(
                                  future: watch(newsGatewayProvider).getMangaNews(),
                                  builder: (context, AsyncSnapshot<NewsState> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    if (snapshot.hasError) {
                                      return Center(child: Text('Something went wrong :('));
                                    }
                                    if (snapshot.data is MangaNewsError) {
                                      return Center(child: Text("No news available."));
                                    }
                                    else {
                                      final mangaNewsState = snapshot.data as MangaNewsFetched;
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: mangaNewsState.mangaNews.length,
                                          itemBuilder: (context, index) {
                                            return NewsBox(
                                              title: mangaNewsState.mangaNews[index]
                                                  .title,
                                              description: mangaNewsState.mangaNews[index]
                                                  .description,
                                              image: mangaNewsState.mangaNews[index].img,
                                              date: mangaNewsState.mangaNews[index].date,
                                            );
                                          }
                                      );
                                    }
                                  },
                                )
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
                              Container(
                                color: Colors.yellow,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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


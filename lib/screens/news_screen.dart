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
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "res/logo-dragonballz.png",
                  height: SizeConfig.heightMultiplier * 10,
                ),
              ),
              actions: [ProfilePictureAvatar()],
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
                        icon: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: SizeConfig.imageSizeMultiplier * 4),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                RecentNewsSlider(),
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
                    builder: (context, watch, child) {
                      //final allNewsProvider = watch(newsGatewayProvider.state);
                      return DefaultTabController(
                        length: 5,
                        child: SizedBox(
                          height: SizeConfig.heightMultiplier * 80,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                labelColor: Colors.deepOrange,
                                isScrollable: true,
                                indicatorColor: Colors.deepOrangeAccent,
                                unselectedLabelColor: Colors.black.withOpacity(
                                    0.3),
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
                                          future: watch(newsGatewayProvider)
                                              .getMangaNews(),
                                          builder: (context, AsyncSnapshot<
                                              NewsState> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(child: Text(
                                                  'Something went wrong :('));
                                            }
                                            if (snapshot
                                                .data is MangaNewsError) {
                                              return Center(child: Text(
                                                  "No news available."));
                                            }
                                            else {
                                              final mangaNewsState = snapshot
                                                  .data as MangaNewsFetched;
                                              return NewsListView(
                                                  state: mangaNewsState);
                                            }
                                          },
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        child: FutureBuilder(
                                          future: watch(newsGatewayProvider)
                                              .getMangaNews(),
                                          builder: (context, AsyncSnapshot<
                                              NewsState> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(child: Text(
                                                  'Something went wrong :('));
                                            }
                                            if (snapshot
                                                .data is MangaNewsError) {
                                              return Center(child: Text(
                                                  "No news available."));
                                            }
                                            else {
                                              final mangaNewsState = snapshot
                                                  .data as MangaNewsFetched;
                                              return NewsListView(
                                                  state: mangaNewsState);
                                            }
                                          },
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        child: FutureBuilder(
                                          future: watch(newsGatewayProvider)
                                              .getMangaNews(),
                                          builder: (context, AsyncSnapshot<
                                              NewsState> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(child: Text(
                                                  'Something went wrong :('));
                                            }
                                            if (snapshot
                                                .data is MangaNewsError) {
                                              return Center(child: Text(
                                                  "No news available."));
                                            }
                                            else {
                                              final mangaNewsState = snapshot
                                                  .data as MangaNewsFetched;
                                              return NewsListView(
                                                  state: mangaNewsState);
                                            }
                                          },
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        child: FutureBuilder(
                                          future: watch(newsGatewayProvider)
                                              .getMangaNews(),
                                          builder: (context, AsyncSnapshot<
                                              NewsState> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(child: Text(
                                                  'Something went wrong :('));
                                            }
                                            if (snapshot
                                                .data is MangaNewsError) {
                                              return Center(child: Text(
                                                  "No news available."));
                                            }
                                            else {
                                              final mangaNewsState = snapshot
                                                  .data as MangaNewsFetched;
                                              return NewsListView(
                                                  state: mangaNewsState);
                                            }
                                          },
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        child: FutureBuilder(
                                          future: watch(newsGatewayProvider)
                                              .getMangaNews(),
                                          builder: (context, AsyncSnapshot<
                                              NewsState> snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            if (snapshot.hasError) {
                                              return Center(child: Text(
                                                  'Something went wrong :('));
                                            }
                                            if (snapshot
                                                .data is MangaNewsError) {
                                              return Center(child: Text(
                                                  "No news available."));
                                            }
                                            else {
                                              final mangaNewsState = snapshot
                                                  .data as MangaNewsFetched;
                                              return NewsListView(
                                                  state: mangaNewsState);
                                            }
                                          },
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ],
            )
        ),
      ),
    );
  }
}


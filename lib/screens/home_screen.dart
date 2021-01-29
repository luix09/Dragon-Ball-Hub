import 'package:dragonballhub/screens/anime_screen.dart';
import 'package:dragonballhub/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'manga_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _screens = <Widget>[
    NewsContainer(),
    MangaScreen(),
    AnimeScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final logoutButton = IconButton(
      icon: Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, "/settings");
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("DB HUB NEWS"),
          centerTitle: true,
          backgroundColor: Colors.red,
          actions: [
            logoutButton,
          ],
        ),
        body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'News'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Manga'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Anime'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }
}

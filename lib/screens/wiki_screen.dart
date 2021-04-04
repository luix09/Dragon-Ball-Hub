import 'package:flutter/material.dart';

class WikiScreen extends StatefulWidget {
  static const String id = "/wiki_screen";
  @override
  _WikiScreenState createState() => _WikiScreenState();
}

class _WikiScreenState extends State<WikiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Wiki Screen"),
        ),
      ),
    );
  }
}

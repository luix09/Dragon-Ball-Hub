import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  static const String id = "/gallery_screen";
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Gallery Screen"
        ),
      ),
    );
  }
}

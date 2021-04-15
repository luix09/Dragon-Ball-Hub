import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  final bool isEnabled;

  SearchBar({
    required this.hintText,
    this.isEnabled = true,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          cursorRadius: Radius.circular(50),
          showCursor: widget.isEnabled,
          decoration: InputDecoration(
              enabled: widget.isEnabled,
              border: InputBorder.none,
              prefixIcon:
              Icon(Icons.search, color: Colors.black.withOpacity(0.7)),
              hintText: widget.hintText),
        ),
      ),
    );
  }
}
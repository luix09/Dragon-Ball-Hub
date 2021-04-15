import 'package:dragonballhub/custom_widgets/search_page_widgets.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';

class SearchNewsPage extends StatefulWidget {
  static const String id = "/search_page";
  final String hintText;

  SearchNewsPage({required this.hintText});

  @override
  _SearchNewsPageState createState() => _SearchNewsPageState();
}

class _SearchNewsPageState extends State<SearchNewsPage> {

  final Map<String, Color> chipLabels = {
    "Manga": Colors.orange,
    "Super": Colors.purple,
    "Z": Colors.yellow,
    "Videogames": Colors.blue,
  };

  int? _indexSelected;

  Widget getChip({
    required String label,
    required Color color,
    required bool selected,
    required int index}) {
    return ChoiceChip(
      backgroundColor: color,
      avatar: selected ? Icon(Icons.check) : Icon(Icons.fiber_manual_record, size: 10,),
      elevation: 3,
      selectedShadowColor: Colors.black,
      pressElevation: 5,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      labelPadding: const EdgeInsets.all(0),
      selected: selected,
      selectedColor: color,
      onSelected: (bool selected) {
        setState(() {
          if(selected == true && _indexSelected != index)
            _indexSelected = index;
          else
            _indexSelected = null;
        });
      },
      label: Text(
        label,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.orange, Colors.deepOrange]
              )
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Material(
                  elevation: 25.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Hero(
                          tag: 'search',
                          child: SearchBar(
                            hintText: widget.hintText
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(2),
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            ...List.generate(chipLabels.length, (index) {
                              // A bit hardcoded heh? :D
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                                child: getChip(
                                    label: chipLabels.keys.toList()[index],
                                    color: chipLabels[chipLabels.keys.toList()[index]]!,
                                    selected: _indexSelected == index,
                                    index: index
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
        ),
      ),
    );
  }
}

import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final myProvider = Provider((ref) => "Hello Flutter!");

class NewsContainer extends StatefulWidget {
  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {

  static final int fakeSize = 100;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Consumer(
            builder: (context, watch, child){
              final listTexts = watch(listProvider(fakeSize));
              return Text('${listTexts[index]}');
            },
          )
        );
      },
      itemCount: fakeSize,
    );
  }
}

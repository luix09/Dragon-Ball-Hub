import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DbhDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
        ),
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            IconButton(icon: Icon(Icons.logout, size: SizeConfig.heightMultiplier * 5,), onPressed: () {
              context.read(userAuthProvider).signOut();
            })
          ],
        ),
      ),
    );
  }
}
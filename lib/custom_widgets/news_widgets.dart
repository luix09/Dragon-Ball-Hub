import 'package:dragonballhub/utils/layout_responsiveness.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeBackWidget extends StatelessWidget {
  final double height;

  WelcomeBackWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              "Welcome back, Luigi",
              style: GoogleFonts.nunito(
                letterSpacing: 0,
                fontSize: SizeConfig.textMultiplier * 3.8,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          Flexible(
            flex: 2,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).dividerColor,
            ),
          ),
        ],
      ),
    );
  }
}

class NewsBox extends StatelessWidget {

  String image;
  String title;
  String description;
  String date;

  NewsBox({
    required this.title,
    required this.image,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 20,
      width: SizeConfig.widthMultiplier * 85,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(2, 5))
          ]),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: SizeConfig.aspectRatio! * 1.2,
              child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(image,
                          fit: BoxFit.cover))),
            ),
          ),
          Flexible(
            flex: 5,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.widthMultiplier * 1.8, top: 10),
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.heightMultiplier * 1,
                  right: SizeConfig.widthMultiplier * 1.8,
                  child: Text(
                    date,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.textMultiplier * 1.2,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfilePictureAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: IconButton(
        iconSize: SizeConfig.imageSizeMultiplier * 10,
        icon: CircleAvatar(
          radius: SizeConfig.imageSizeMultiplier * 6,
          backgroundImage: AssetImage("res/goku-greeting.png"),
        ),
        onPressed: () {
          //Navigator.push(context,
          //  MaterialPageRoute(builder: (context) => UserPage()));
        },
      ),
    );
  }
}

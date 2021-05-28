import 'dart:convert';

import 'news_model.dart';

class NewsParser {

  static List<NewsModel> parseNews(String responseBody, String key) {
    Map<String, dynamic> parsed = json.decode(responseBody);
    List<NewsModel> listNews = [];
    for(int i = 0; i < parsed[key].length; i++) {
      listNews.add(NewsModel.fromJson(parsed[key][i]));
    }
    return listNews;
  }

}
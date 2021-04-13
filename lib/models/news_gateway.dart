import 'dart:convert';
import 'package:dragonballhub/models/news_model.dart';
import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/db_states.dart';
import 'package:dragonballhub/states/dbsuper_states.dart';
import 'package:dragonballhub/states/dbz_states.dart';
import 'package:dragonballhub/states/manga_states.dart';
import 'package:dragonballhub/states/news_states.dart';
import 'package:dragonballhub/states/recent_news.dart';
import 'package:dragonballhub/states/videogames_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NewsGateway extends StateNotifier<NewsState> {
  final ApiNews api;

  NewsGateway({required this.api}) : super(NewsInitialState());

  List<NewsModel> parseNews(String responseBody, String key) {
    Map<String, dynamic> parsed = json.decode(responseBody);
    List<NewsModel> listNews = [];
    for(int i = 0; i < parsed[key].length; i++) {
      listNews.add(NewsModel.fromJson(parsed[key][i]));
    }
    return listNews;
  }

  Future<NewsState> getRecentNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchRecentNews();
      var recentNews = parseNews(response.body, "recent_news");
      state = RecentNewsFetched(recentNews);
    } catch (e) {
      state = RecentNewsError(errorMsg: e.toString());
      print("getRecentNews() error: " + e.toString());
    }
    return state;
  }

  Future<NewsState> getMangaNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchMangaNews();
      var mangaNews = parseNews(response.body, "manga_news");
      state = MangaNewsFetched(mangaNews);
    } catch (e) {
      state = MangaNewsError(errorMsg: e.toString());
      print("getMangaNews() error: " + e.toString());
    }
    return state;
  }

  Future<NewsState> getDbSuperNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchDbSuperNews();
      var dbSuperNews = parseNews(response.body, "dbs_news");
      state = DbSuperNewsFetched(dbSuperNews);
    } catch (e) {
      state = DbSuperNewsError(errorMsg: e.toString());
      print("getDbSuperNews() error: " + e.toString());
    }
    return state;
  }

  Future<NewsState> getDbzNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchDbzNews();
      var dbzNews = parseNews(response.body, "dbz_news");
      state = DbzNewsFetched(dbzNews);
    } catch (e) {
      state = DbzNewsError(errorMsg: e.toString());
      print("getDbzNews() error: " + e.toString());
    }
    return state;
  }

  Future<NewsState> getDbNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchDbNews();
      var dbzNews = parseNews(response.body, "db_news");
      state = DbNewsFetched(dbzNews);
    } catch (e) {
      state = DbNewsError(errorMsg: e.toString());
      print("getDbNews() error: " + e.toString());
    }
    return state;
  }

  Future<NewsState> getVideogamesNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchVideogamesNews();
      var videogamesNews = parseNews(response.body, "videogames_news");
      state = VideogamesNewsFetched(videogamesNews);
    } catch (e) {
      state = VideogamesNewsError(errorMsg: e.toString());
      print("getVideogamesNews() error: " + e.toString());
    }
    return state;
  }
}
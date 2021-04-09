import 'dart:convert';

import 'package:dragonballhub/models/news_model.dart';
import 'package:dragonballhub/repository/api_news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: add Equatable package
abstract class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState{
  const NewsInitialState();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class MangaNewsFetched extends NewsState {
  List<NewsModel> mangaNews;
  MangaNewsFetched({required this.mangaNews});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsFetched && o.mangaNews == mangaNews;
  }

  @override
  int get hashCode => mangaNews.hashCode;
}

class MangaNewsError extends NewsState {
  String errorMsg;
  MangaNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}

class NewsGateway extends StateNotifier<NewsState> {
  final ApiNews api;

  NewsGateway({required this.api}) : super(NewsInitialState());

  List<NewsModel> parseNews(String responseBody) {
    Map<String, dynamic> parsed = json.decode(responseBody);
    List<NewsModel> listNews = [];
    for(int i = 0; i < parsed["manga_news"].length; i++) {
      listNews.add(NewsModel.fromJson(parsed['manga_news'][i]));
    }
    return listNews;
  }

  Future<NewsState> getMangaNews() async {
    try {
      state = NewsLoading();
      final response = await api.fetchMangaNews();
      var mangaNews = parseNews(response.body);
      state = MangaNewsFetched(mangaNews: mangaNews);
    } catch (e) {
      state = MangaNewsError(errorMsg: e.toString());
      print("Message: " + e.toString());
    }
    return state;
  }
}
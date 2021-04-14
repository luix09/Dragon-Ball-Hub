import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/videogames_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class VideogamesNewsStateNotifier extends StateNotifier<VideogamesState> {
  final ApiNews api;

  VideogamesNewsStateNotifier({required this.api}) : super(InitialVideogamesState());

  Future<void> getVideogamesNews() async {
    try {
      state = LoadingVideogamesState();
      final response = await api.fetchVideogamesNews();
      var videogamesNews = NewsParser.parseNews(response.body, "videogames_news");
      state = VideogamesNewsFetched(newsList: videogamesNews);
    } catch (e) {
      state = VideogamesNewsError(errorMsg: e.toString());
      print("getVideogamesNews() error: " + e.toString());
    }
  }
}
import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/manga_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class MangaNewsStateNotifier extends StateNotifier<MangaState> {
  final ApiNews api;

  MangaNewsStateNotifier({required this.api}) : super(InitialMangaState());

  Future<void> getMangaNews() async {
    try {
      state = LoadingMangaState();
      final response = await api.fetchMangaNews();
      var mangaNews = NewsParser.parseNews(response.body, "manga_news");
      state = MangaNewsFetched(newsList: mangaNews);
    } catch (e) {
      state = MangaNewsError(errorMsg: e.toString());
      print("getMangaNews() error: " + e.toString());
    }
  }
}
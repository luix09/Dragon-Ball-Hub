import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/db_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class DbNewsStateNotifier extends StateNotifier<DbState> {
  final ApiNews api;

  DbNewsStateNotifier({required this.api}) : super(InitialDbState());

  Future<void> getDbNews() async {
    try {
      state = LoadingDbState();
      final response = await api.fetchDbNews();
      var dbNews = NewsParser.parseNews(response.body, "db_news");
      state = DbNewsFetched(newsList: dbNews);
    } catch (e) {
      state = DbNewsError(errorMsg: e.toString());
      print("getDbNews() error: " + e.toString());
    }
  }
}
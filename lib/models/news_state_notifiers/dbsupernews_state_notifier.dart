import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/dbsuper_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class DbSuperNewsStateNotifier extends StateNotifier<DbSuperState> {
  final ApiNews api;

  DbSuperNewsStateNotifier({required this.api}) : super(InitialDbSuperState());

  Future<void> getDbSuperNews() async {
    try {
      state = LoadingDbSuperState();
      final response = await api.fetchDbSuperNews();
      var dbSuperNews = NewsParser.parseNews(response.body, "dbs_news");
      state = DbSuperNewsFetched(newsList: dbSuperNews);
    } catch (e) {
      state = DbSuperNewsError(errorMsg: e.toString());
      print("getDbSuperNews() error: " + e.toString());
    }
  }
}
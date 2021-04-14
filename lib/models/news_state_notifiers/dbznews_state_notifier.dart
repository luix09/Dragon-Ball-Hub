import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/db_states.dart';
import 'package:dragonballhub/states/dbz_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class DbZNewsStateNotifier extends StateNotifier<DbZState> {
  final ApiNews api;

  DbZNewsStateNotifier({required this.api}) : super(InitialDbZState());

  Future<void> getDbZNews() async {
    try {
      state = LoadingDbZState();
      final response = await api.fetchDbZNews();
      var dbZNews = NewsParser.parseNews(response.body, "dbz_news");
      state = DbZNewsFetched(newsList: dbZNews);
    } catch (e) {
      state = DbZNewsError(errorMsg: e.toString());
      print("getDbZNews() error: " + e.toString());
    }
  }
}
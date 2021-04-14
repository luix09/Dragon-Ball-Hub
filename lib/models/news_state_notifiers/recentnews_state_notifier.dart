import 'package:dragonballhub/repository/api_news.dart';
import 'package:dragonballhub/states/recent_news.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../news_parser.dart';

class RecentNewsStateNotifier extends StateNotifier<RecentNewsState> {
  final ApiNews api;

  RecentNewsStateNotifier({required this.api}) : super(InitialRecentNewsState());

  Future<void> getRecentNews() async {
    try {
      state = LoadingRecentNewsState();
      final response = await api.fetchRecentNews();
      var recentNews = NewsParser.parseNews(response.body, "recent_news");
      state = RecentNewsFetched(newsList: recentNews);
    } catch (e) {
      state = RecentNewsError(errorMsg: e.toString());
      print("getRecentNews() error: " + e.toString());
    }
  }
}
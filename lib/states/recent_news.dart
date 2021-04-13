import 'package:dragonballhub/models/news_model.dart';
import 'news_states.dart';

class RecentNewsFetched extends NewsState {
  RecentNewsFetched(List<NewsModel> newsList) : super(newsList: newsList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecentNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class RecentNewsError extends NewsState {
  String errorMsg;
  RecentNewsError({required this.errorMsg}) : super(newsList: null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecentNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
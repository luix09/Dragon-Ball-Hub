import 'package:dragonballhub/models/news_model.dart';
import 'news_states.dart';

class DbSuperNewsFetched extends NewsState {
  DbSuperNewsFetched(List<NewsModel> newsList) : super(newsList: newsList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbSuperNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class DbSuperNewsError extends NewsState {
  String errorMsg;
  DbSuperNewsError({required this.errorMsg}) : super(newsList: null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbSuperNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
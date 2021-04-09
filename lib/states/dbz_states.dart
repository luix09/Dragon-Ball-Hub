import 'package:dragonballhub/models/news_model.dart';
import 'news_states.dart';

class DbzNewsFetched extends NewsState {
  DbzNewsFetched(List<NewsModel> newsList) : super(newsList: newsList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbzNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class DbzNewsError extends NewsState {
  String errorMsg;
  DbzNewsError({required this.errorMsg}) : super(newsList: null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbzNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
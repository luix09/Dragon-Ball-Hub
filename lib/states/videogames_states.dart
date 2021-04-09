import 'package:dragonballhub/models/news_model.dart';
import 'news_states.dart';

class VideogamesNewsFetched extends NewsState {
  VideogamesNewsFetched(List<NewsModel> newsList) : super(newsList: newsList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VideogamesNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class VideogamesNewsError extends NewsState {
  String errorMsg;
  VideogamesNewsError({required this.errorMsg}) : super(newsList: null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VideogamesNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
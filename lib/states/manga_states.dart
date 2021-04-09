import 'package:dragonballhub/models/news_model.dart';
import 'news_states.dart';

class MangaNewsFetched extends NewsState {
  MangaNewsFetched(List<NewsModel> newsList) : super(newsList: newsList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class MangaNewsError extends NewsState {
  String errorMsg;
  MangaNewsError({required this.errorMsg}) : super(newsList: null);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
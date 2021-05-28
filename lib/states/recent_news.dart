import 'package:dragonballhub/models/news_model.dart';

abstract class RecentNewsState {}

class InitialRecentNewsState extends RecentNewsState {
  InitialRecentNewsState();
}

class LoadingRecentNewsState extends RecentNewsState {
  LoadingRecentNewsState();
}

class RecentNewsFetched extends RecentNewsState {
  final List<NewsModel>? newsList;
  RecentNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecentNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class RecentNewsError extends RecentNewsState {
  String errorMsg;
  RecentNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecentNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
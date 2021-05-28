import 'package:dragonballhub/models/news_model.dart';

abstract class DbState {}

class InitialDbState extends DbState {
  InitialDbState();
}

class LoadingDbState extends DbState {
  LoadingDbState();
}

class DbNewsFetched extends DbState{
  final List<NewsModel>? newsList;
  DbNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class DbNewsError extends DbState {
  String errorMsg;
  DbNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
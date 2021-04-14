import 'package:dragonballhub/models/news_model.dart';

abstract class DbSuperState {}

class InitialDbSuperState extends DbSuperState {
  InitialDbSuperState();
}

class LoadingDbSuperState extends DbSuperState {
  LoadingDbSuperState();
}

class DbSuperNewsFetched extends DbSuperState {
  final List<NewsModel>? newsList;
  DbSuperNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbSuperNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class DbSuperNewsError extends DbSuperState {
  String errorMsg;
  DbSuperNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbSuperNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
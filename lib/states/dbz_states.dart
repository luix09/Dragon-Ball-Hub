import 'package:dragonballhub/models/news_model.dart';

abstract class DbZState {}

class InitialDbZState extends DbZState {
  InitialDbZState();
}

class LoadingDbZState extends DbZState {
  LoadingDbZState();
}

class DbZNewsFetched extends DbZState {
  final List<NewsModel>? newsList;
  DbZNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbZNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class DbZNewsError extends DbZState {
  String errorMsg;
  DbZNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DbZNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
import 'package:dragonballhub/models/news_model.dart';

abstract class VideogamesState {}

class InitialVideogamesState extends VideogamesState {
  InitialVideogamesState();
}

class LoadingVideogamesState extends VideogamesState {
  LoadingVideogamesState();
}

class VideogamesNewsFetched extends VideogamesState {
  final List<NewsModel>? newsList;
  VideogamesNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VideogamesNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class VideogamesNewsError extends VideogamesState {
  String errorMsg;
  VideogamesNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is VideogamesNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
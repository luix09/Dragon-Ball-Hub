import 'package:dragonballhub/models/news_model.dart';

abstract class MangaState {}

class InitialMangaState extends MangaState {
  InitialMangaState();
}

class LoadingMangaState extends MangaState {
  LoadingMangaState();
}

class MangaNewsFetched extends MangaState {
  final List<NewsModel>? newsList;
  MangaNewsFetched({required this.newsList});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsFetched && o.newsList == newsList;
  }

  @override
  int get hashCode => newsList.hashCode;
}

class MangaNewsError extends MangaState {
  String errorMsg;
  MangaNewsError({required this.errorMsg});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MangaNewsError && o.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;
}
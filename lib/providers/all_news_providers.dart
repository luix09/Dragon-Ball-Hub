import 'package:dragonballhub/models/news_state_notifiers/dbnews_state_notifier.dart';
import 'package:dragonballhub/models/news_state_notifiers/dbsupernews_state_notifier.dart';
import 'package:dragonballhub/models/news_state_notifiers/dbznews_state_notifier.dart';
import 'package:dragonballhub/models/news_state_notifiers/manganews_state_notifier.dart';
import 'package:dragonballhub/models/news_state_notifiers/recentnews_state_notifier.dart';
import 'package:dragonballhub/models/news_state_notifiers/videogames_state_notifier.dart';
import 'package:dragonballhub/providers/top_level_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recentNewsProvider = StateNotifierProvider<RecentNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return RecentNewsStateNotifier(api: apiProvider.data!.value);
}
);

final mangaProvider = StateNotifierProvider<MangaNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return MangaNewsStateNotifier(api: apiProvider.data!.value);
}
);

final dbSuperProvider = StateNotifierProvider<DbSuperNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return DbSuperNewsStateNotifier(api: apiProvider.data!.value);
}
);

final dbZProvider = StateNotifierProvider<DbZNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return DbZNewsStateNotifier(api: apiProvider.data!.value);
}
);

final dbProvider = StateNotifierProvider<DbNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return DbNewsStateNotifier(api: apiProvider.data!.value);
}
);

final videogamesProvider = StateNotifierProvider<VideogamesNewsStateNotifier>((ref) {
  final apiProvider = ref.watch(newsProvider);
  return VideogamesNewsStateNotifier(api: apiProvider.data!.value);
}
);
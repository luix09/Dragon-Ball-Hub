//TODO: add Equatable package
import 'package:dragonballhub/models/news_model.dart';

class NewsState {
  final List<NewsModel>? newsList;
  NewsState({required this.newsList});
}

class NewsInitialState extends NewsState{
  NewsInitialState() : super(newsList: null);
}

class NewsLoading extends NewsState {
  NewsLoading() : super(newsList: null);
}

part of 'news_cubit.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {
  NewsInitial();
}

class NewsLoading extends NewsState {
  NewsLoading();
}

class NewsCompleted extends NewsState {
  List<News>? news;
  NewsCompleted(this.news);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}

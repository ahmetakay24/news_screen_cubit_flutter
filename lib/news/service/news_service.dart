import 'dart:io';
import 'package:bloc_exercise/news/model/news_model.dart';
import 'package:dio/dio.dart';

class NewsService {
  final Dio dio = Dio();

  final String newsUrl =
      "https://newsdata.io/api/1/news?apikey=pub_446983bf2a5b977c01712e4addb96241cbc58&language=en&category=world";

  Future<List<News>?> getNews() async {
    dio.options.responseType = ResponseType.json;
    final response = await dio.get(newsUrl);

    if (response.statusCode == HttpStatus.ok) {
      final data = response.data["results"] as List;
      final news = data
          .map(
            (e) => News.fromJson(e),
          )
          .toList();
      return news;
    } else {
      return null;
    }
  }
}

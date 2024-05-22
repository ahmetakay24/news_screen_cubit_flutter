import 'dart:async';
import 'package:bloc_exercise/news/model/news_model.dart';
import 'package:bloc_exercise/news/service/news_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  Future<void> loadNews() async {
    try {
      emit(NewsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final response = NewsService().getNews();
      emit(NewsCompleted(response));
    } catch (e) {
      emit(NewsError("Error"));
    }
  }
}

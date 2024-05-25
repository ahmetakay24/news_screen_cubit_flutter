import 'dart:async';
import 'package:bloc_exercise/news/model/news_model.dart';
import 'package:bloc_exercise/news/repository/news_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _newsRepository;
  NewsCubit(this._newsRepository) : super(NewsInitial());

  Future<void> loadNews() async {
    try {
      emit(NewsLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final response = await _newsRepository.getNews();
      emit(NewsCompleted(response));
    } catch (e) {
      emit(NewsError("Error"));
    }
  }
}

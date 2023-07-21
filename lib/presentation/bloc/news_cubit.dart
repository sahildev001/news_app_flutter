// lib/presentation/bloc/news_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newa_app_test/utils/constants.dart';

import '../../data/models/news_model.dart';
import '../../data/repository/news_repository.dart';

class NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;

  NewsLoaded(this.news);
}

class NewsError extends NewsState {
  final String errorMessage;

  NewsError(this.errorMessage);
}

class OpenNewsList extends NewsState {
  final bool openList;

  OpenNewsList({required this.openList});
}

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  int currentKeyIndex = 0;
  List<NewsModel> allNews = []; // Store all the news from the API
  List<NewsModel> displayedNews = []; // Store the filtered news for display

  NewsCubit({required this.newsRepository}) : super(NewsLoading());

  Future<void> fetchLatestNews() async {
    try {
      String _apiKey = Constants.API_KEY[currentKeyIndex];
      final news = await newsRepository.fetchLatestNews(apiKey: _apiKey);
      allNews = news;
      displayedNews = news;
      emit(NewsLoaded(news));
    } catch (e) {
      if (currentKeyIndex == 2) {
        currentKeyIndex = 0;
      } else {
        currentKeyIndex++;
      }
      emit(NewsError('Failed to load news  ${e}'));
    }
  }

  void switchView({required bool openList}) {
    emit(OpenNewsList(openList: openList));
  }

  void searchNews(String query) {

    if (query.isEmpty) {
      // If the search query is empty, display all news
      displayedNews = allNews;
    } else {
      // If there is a search query, filter the news based on the query
      displayedNews = allNews
          .where((news) =>
      news.title.toLowerCase().contains(query.toLowerCase())).toList();
      print ("displayedNews length ::  ${displayedNews.length}");
      print ("allnews  length ::  ${allNews.length}");
    }
    emit(NewsLoaded(displayedNews));
  }
}

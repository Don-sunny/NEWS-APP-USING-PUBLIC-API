import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

  Future<List<NewsModel>> fetchAllnews(
      {required int pageIndex, required String sortBy}) async {
    newsList =
        await NewsAPiServices.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
  }

  NewsModel findByDate({required String publishedAt}) {
    return newsList
        .firstWhere((newsmodel) => newsmodel.publishedAt == publishedAt);
  }

  Future<List<NewsModel>> fetchTopHeadlines() async {
    newsList = await NewsAPiServices.getTopHeadlines();
    return newsList;
  }

  Future<List<NewsModel>> searchNews({required String query}) async {
    newsList = await NewsAPiServices.searchNews(query: query);
    return newsList;
  }
}

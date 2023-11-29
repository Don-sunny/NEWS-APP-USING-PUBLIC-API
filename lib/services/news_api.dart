import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/consts/api_const.dart';
import 'package:news_app/models/news_model.dart';

import 'package:http/http.dart' as http;

class NewsAPiServices {
  static Future<List<NewsModel>> getAllNews(
      {required int page, required String sortBy}) async {
    //
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=');

    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        // "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com,thenextweb.com",
        "page": page.toString(),
        'sortBy': sortBy.toString(),
        // "apiKEY": API_KEY
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      // print('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        // log(v.toString());
        // print(data["articles"].length.toString());
      }

      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {'country': 'us'});
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      debugPrint('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        // log(v.toString());
        // print(data["articles"].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }

  static Future<List<NewsModel>> searchNews({required String query}) async {
    //
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=');

    try {
      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": query,
        "pageSize": "10",
        "domains": "techcrunch.com,thenextweb.com",
        // "apiKEY": API_KEY
      });
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      // print('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        // log(v.toString());
        // print(data["articles"].length.toString());
      }

      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}

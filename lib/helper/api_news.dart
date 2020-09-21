import 'package:covid_19/models/article.dart';

import 'package:covid_19/secret.dart';
import 'package:dio/dio.dart';

class News {
  Dio dio = new Dio();
  Response response;
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?q=covid&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=$apiKey";

    var response = await dio.get(url);

    if (response.data['status'] == "ok") {
      response.data["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategorie {
  Dio dio = new Dio();
  Response response;
  List<Article> news = [];

  Future<void> getNewsForCategory(String country) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=$country&q=covid&apiKey=$apiKey";

    var response = await dio.get(url);

    if (response.data['status'] == "ok") {
      response.data["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

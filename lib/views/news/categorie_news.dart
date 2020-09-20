import 'package:covid_19/helper/api_covid.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/helper/api_news.dart';
import 'package:covid_19/views/news/news_widgets.dart';
import 'package:provider/provider.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  void getNews(String country) async {
    NewsForCategorie news = NewsForCategorie();
    await news.getNewsForCategory(country);
    newslist = news.news;
    if (this._loading) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final liveCountry = Provider.of<AllData>(context);
    getNews(liveCountry.oneResponse.data['countryInfo']['iso2']);

    return Scaffold(
      appBar: newsBar(),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newslist[index].urlToImage ?? "",
                          title: newslist[index].title ?? "",
                          desc: newslist[index].description ?? "",
                          content: newslist[index].content ?? "",
                          posturl: newslist[index].articleUrl ?? "",
                          publshedAt: DateTime.parse(
                                  newslist[index].publshedAt.toString()) ??
                              Null,
                        );
                      }),
                ),
              ),
            ),
    );
  }
}

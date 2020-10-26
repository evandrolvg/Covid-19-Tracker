import 'package:flutter/material.dart';
import 'package:covid_19/helper/news_categories.dart';
import 'package:covid_19/views/news/news_widgets.dart';
import 'package:covid_19/models/categorie_model.dart';
import 'package:covid_19/views/news/categorie_news.dart';

import '../../helper/api_news.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool _loading;
  var newslist;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    if (this.mounted) {
      if (this._loading) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _loading = true;
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newsBar(context, false),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                index: index,
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),

                      /// News Article
                      Container(
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
                                publshedAt: DateTime.parse(newslist[index].publshedAt.toString()) ?? Null,
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int index;
  final String imageAssetUrl, categoryName;

  const CategoryCard({Key key, this.index, this.imageAssetUrl, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        index != 0
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryNews(
                          newsCategory: categoryName.toLowerCase(),
                        )))
            // ignore: unnecessary_statements
            : null;
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(imageAssetUrl, height: 60, width: 120, fit: BoxFit.cover),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: index == 0
                  ? BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 2), borderRadius: BorderRadius.circular(5), color: Colors.black26)
                  : BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

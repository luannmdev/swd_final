import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/news.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/news/newsViewModel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsDetailViewModel with ChangeNotifier {
  bool loadingStatus = true;
  NewsViewModel article = NewsViewModel();

  void getNewsDetailById(int idNews) async {
    // print('aaaaaaaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
    News temp = await WebService().getNewsDetailById(idNews);
    // print('NewsDetailViewModel - compCode: ' + temp.compCode);
    notifyListeners();
    this.article = NewsViewModel(article: temp);
    // print('this.article: ' + this.article.toString());
    // print('this.article: ' + this.article.compCode);
    if (this.article == null) {
      // print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
      this.loadingStatus = true;
    } else {
      this.loadingStatus = false;
    }
    notifyListeners();
  }
}

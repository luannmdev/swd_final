import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/news.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/news/newsViewModel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class NewsListViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<NewsViewModel> articlesList = List<NewsViewModel>();
  int countPage = 0;

  void topHeadlines(int pageNum, String uniCode, String majorCode, String subject) async {
    if (pageNum <= countPage) {
      return;
    }
    this.countPage++;
    print('topHeadlines: $pageNum - $uniCode - $majorCode - $subject');
    List<News> newsArticles = await WebService().fetchTopHeadlines(pageNum,uniCode,majorCode,subject);
    print('$pageNum ${newsArticles.length}');
    notifyListeners();

    this.articlesList.addAll(newsArticles
        .map((article) => NewsViewModel(article: article))
        .toList());


    if (this.articlesList.isEmpty) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }

    notifyListeners();
  }
}

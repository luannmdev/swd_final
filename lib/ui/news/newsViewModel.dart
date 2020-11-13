
import 'package:swdprojectbackup/models/news.dart';

class NewsViewModel {
  News _newsArticle;

  NewsViewModel({News article}) : _newsArticle = article;

  int get id {
    return _newsArticle.id;
  }

  String get compCode {
    return _newsArticle.compCode;
  }

  String get name {
    return _newsArticle.name;
  }

  String get description {
    return _newsArticle.description;
  }

  String get position {
    return _newsArticle.position;
  }

  String get benefit {
    return _newsArticle.benefit;
  }

  int get quantity {
    return _newsArticle.quantity;
  }

  String get startDate {
    return _newsArticle.startDate;
  }

  String get endDate {
    return _newsArticle.endDate;
  }

}
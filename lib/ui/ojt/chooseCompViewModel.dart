import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/companyChoose.dart';
import 'package:swdprojectbackup/models/news.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/news/newsViewModel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class ChooseCompViewModel with ChangeNotifier {
  LoadingStatus loadingStatus;
  List<CompanyChoose> compList;

  void getCompChoose(String uniCode, String majorCode, String subject) async {
    List<CompanyChoose> temp = await WebService().getCompanyChoose(uniCode,majorCode,subject);
    // print('NewsDetailViewModel - compCode: ' + temp.compCode);
    notifyListeners();
    this.compList = temp;
    // print('this.article: ' + this.article.toString());
    // print('this.article: ' + this.article.compCode);
    if (this.compList == null) {
      // print('CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC');
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}

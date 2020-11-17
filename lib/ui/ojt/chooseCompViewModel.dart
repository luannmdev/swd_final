import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdprojectbackup/models/application.dart';
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
  bool applyStatus;

  void getCompChoose(String uniCode, String majorCode, String subject) async {
    List<CompanyChoose> temp = await WebService().getCompanyChoose(uniCode,majorCode,subject);
    // print('NewsDetailViewModel - compCode: ' + temp.compCode);
    notifyListeners();
    this.compList = temp;
    if (this.compList == null) {
      this.loadingStatus = LoadingStatus.empty;
    } else {
      this.loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  Future<bool> applyJob(List<Application> appList) async {
    print('apply job processingggggg');
    this.applyStatus = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = await prefs.getString('idToken');
    bool res = true;
    // appList.forEach((app)  {
    //   print('viewmodel: appid = ${app.jobId}');
    // });
    appList.forEach((app) async {
      res = res & await WebService().applyJob(app,idToken);
    });
    notifyListeners();
    this.applyStatus = res;
    print('applyStatus = $applyStatus');
    notifyListeners();
    return res;
  }

}

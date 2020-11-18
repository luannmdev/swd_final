import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/models/profile.dart';
import 'package:swdprojectbackup/services/web_service.dart';

enum LoadingStatus {
  completed,
  processing,
  error,
}

class ProfileViewModel with ChangeNotifier {
  bool loadingStatus = true;
  Profile profile = new Profile();
  Account account = new Account();
  LoadingStatus updateStatus;

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = await prefs.getString('email');
    String token = await prefs.getString('token');
    print('aaaaaaaaaaaaa - $email');
    // print('$email - $token');
    Profile pro = await WebService().getProfile(email,token);
    // int lastSent = 0;
    // if (pro.lastSent != null) {
    //   lastSent = pro.lastSent;
    // }
    notifyListeners();
    this.profile = Profile(
      code: pro.code,
      email: pro.email,
      fullname: pro.fullname,
      phoneNo: pro.phoneNo,
      cv: pro.cv,
      gpa: pro.gpa,
      majorCode: pro.majorCode,
      uniCode: pro.uniCode,
      majorName: pro.majorName,
      graduation: pro.graduation,
        lastSent: pro.lastSent
    );
    if (this.profile == null) {
      this.loadingStatus = true;
    } else {
      this.loadingStatus = false;
    }
    notifyListeners();
  }

  void updateProfile(Profile profileNeedToUpdate) async {
    print('update profile');
    print(profileNeedToUpdate.fullname);
    print(profileNeedToUpdate.email);
    print(profileNeedToUpdate.phoneNo);
    print(profileNeedToUpdate.code);
    bool res = await WebService().updateProfile(profileNeedToUpdate);
    notifyListeners();

    if (res == false) {
      this.updateStatus = LoadingStatus.error;
    } else if (res == true) {
      this.updateStatus = LoadingStatus.completed;
    } else {
      this.updateStatus = LoadingStatus.processing;
    }
    notifyListeners();
  }

}

import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/data/repository.dart';
import 'dart:io';

import 'package:swdprojectbackup/ui/login/loginScreen.dart';

class BancherRepository implements Repository {
  //in Memory DB,
  HashMap<String, Account> _account = HashMap();
  Account loggedinUser;


  BancherRepository(){
    Account a1 = new Account();
    a1.setEmail("test1");
    a1.setPass("123");
    this._account['test1'] = a1;
  }

  @override
  bool contains(String email) {
    return _account[email] != null;
  }

  @override
  void signUpUser(Account user, Function onSuccess, Function onError) {
    try {
      _account[user.getEmail().toLowerCase()] = user;
      loggedinUser = user;
      onSuccess(); //mocking success
    } catch (e) {
      //mocking error
      onError('Something went wrong!');
    }
  }

  @override
  bool isLoggedIn() {
    return loggedinUser != null;
  }

  @override
  bool isAuthorizeduser(String email, String pass) {
    return _account[email] != null &&
        _account[email.toLowerCase()].getPassWord() == pass;
  }

  @override
  void logout() {
    loggedinUser = null;
  }

  @override
  loggedInUser() {
    return loggedinUser;
  }

  @override
  void login(String email, String pass, Function onSuccess, Function onError) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', "loctpse130asd");
      await prefs.setString('role', "Student");
      loggedinUser = _account[email];
      onSuccess();
    } catch (e) {
      print(e.toString());
      onError('????');
    }
  }
}

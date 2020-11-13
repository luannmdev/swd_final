import 'package:swdprojectbackup/models/account.dart';

class Repository {
  bool contains(String email) {}

  bool isLoggedIn() {}

  bool isAuthorizeduser(String email, String pass) {}

  void signUpUser(Account account, Function onSuccess, Function onError) {}

  void logout() {}

  Account loggedInUser() {}

  void login(String email, String pass, Function onsuccess, Function onError) {}
}

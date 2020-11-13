import 'package:swdprojectbackup/di.dart';
import 'package:swdprojectbackup/domain/login.dart';
import 'package:swdprojectbackup/services/web_service.dart';

class LoginViewModel {
  LoginUsecase _loginUsecase = AppManager.instance().loginUsecase();
  bool loginWithGoogleStatus = false;

  void login(String email, String pass, Function onSuccess, Function onError) {
    _loginUsecase.login(email, pass, onSuccess, onError);
  }

  // void loginWithGoogle() async {
  //   bool login = await WebService().loginWithGoogle();
  //   print(login);
  //   this.loginWithGoogleStatus = login;
  // }

}

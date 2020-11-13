import 'package:swdprojectbackup/data/repository.dart';
import 'package:swdprojectbackup/data/repositotyImpl.dart';
import 'package:swdprojectbackup/domain/login.dart';

class AppManager {
  static AppManager _instance;
  static Repository _repository = BancherRepository();

  AppManager._();

  static AppManager instance() {
    if (_instance == null) {
      _instance = AppManager._();
    }
    return _instance;
  }

  LoginUsecase loginUsecase() {
    return LoginUsecase(_repository);
  }

  bool isLoggedIn() {
    return _repository.isLoggedIn();
  }

}

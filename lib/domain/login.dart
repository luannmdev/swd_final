import 'package:swdprojectbackup/data/repository.dart';

class LoginUsecase {
  Repository _repository;

  LoginUsecase(Repository repository) {
    _repository = repository;
  }

  void login(String email, String pass, Function onSuccess, Function onError) {
    if (_repository.contains(email)) {
      if (_repository.isAuthorizeduser(email, pass)) {
        // onSuccess('success');
        _repository.login(email, pass, onSuccess, onError);
      } else {
        onError('wrong password');
      }
    } else {
      onError('non registered email');
    }
  }
}

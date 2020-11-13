class Account {
  String _email;
  String _pass; //This is temp, app dont save user pw
  String _role;
  bool _isAdriver;

  User(String email, String pass, bool isAdriver) {
    this._email = email;
    this._pass = pass;
    this._isAdriver = isAdriver;
  }

  String getEmail() {
    return _email;
  }

  String getPassWord() {
    return _pass;
  }

  bool isAdriver() {
    return _isAdriver;
  }

  void setIsAdriver(bool value) {
    this._isAdriver = value;
  }

  void setPass(String value) {
    this._pass = value;
  }

  void setEmail(String value) {
    this._email = value;
  }

  void setRole(String role) {
    this._role = role;
  }

  String getRole() {
    return _role;
  }

  Map<String, dynamic> toJson() {
    return {
      // "email": _email,
      // "role": _role,
      "email": this._email,
      "role": this._role,
    };
  }
}
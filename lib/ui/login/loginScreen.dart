
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swdprojectbackup/services/google_service.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/home/homeScreen.dart';
// import 'package:swdprojectbackup/ui/home/homeScreen.dart';
import 'package:swdprojectbackup/ui/login/loginviewModel.dart';
// import 'package:bancher/ui/register/registerscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../base.dart';

class LoginScreen extends StatefulWidget {
  String _title;
  LoginScreen({String title: 'Login'}) {
    this._title = title;
  }
  String getTitle() {
    return _title;
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

var viewmodel = LoginViewModel();


class _LoginScreenState extends State<LoginScreen> {
  final appLogo = Icon(
    Icons.work,
    size: 90,
    color: Colors.blueAccent,
  );


  @override
  Widget build(BuildContext context) {
    return scaffold(
        widget.getTitle(),
        Container(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                padding: EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    appLogo,
                    // emailInput,
                    // passwordInput,
                    // loginButton(() {
                    //   viewmodel.login(
                    //       email,
                    //       pasw,
                    //       () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(builder: (context) => HomeScreen()),
                    //         );
                    //       },
                    //       // login-fail
                    //       (message) {
                    //         Toast.show(message, context,
                    //             duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    //       });
                    // }),
                    loginByGoogleButton(context),
                    // signupHintText(context)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  static final textStyle = TextStyle(
    fontFamily: 'Anton',
    fontSize: 20,
  );

  // final emailInput = TextField(
  //   onChanged: (text) => {email = text},
  //   decoration: InputDecoration(hintText: 'Email'),
  //   keyboardType: TextInputType.emailAddress,
  //   style: textStyle,
  // );
  //
  // final passwordInput = TextField(
  //     onChanged: (text) => {pasw = text},
  //     decoration: InputDecoration(hintText: 'Password'),
  //     obscureText: true,
  //     style: textStyle);

  loginByGoogleButton(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RaisedButton(
      child: Text('Login with School\'s account'),
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result) {
            Fluttertoast.showToast(
                msg: "Login Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          }else{
            showDialog(context: context, builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Something wrong!'),
                content: Text('Your google account is not registered on app, please contact to your company!'),
              );
            });
          }
        });
      },
    ),
  );

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
  // Widget loginButton(Function onPressed) {
  //   return Center(
  //     child: Padding(
  //       padding: EdgeInsets.all(30),
  //       child: FlatButton(
  //         onPressed: onPressed,
  //         child: Text(
  //           'Login',
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         color: Colors.blue,
  //       ),
  //     ),
  //   );
  // }


  //
  // Widget signupHintText(BuildContext context) {
  //   return RichText(
  //       text: new TextSpan(children: [
  //         TextSpan(
  //           text: 'New User of App? ',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         TextSpan(
  //             text: 'sign up!',
  //             style: TextStyle(
  //               color: Colors.black,
  //               decoration: TextDecoration.underline,
  //             ),
  //             recognizer: new TapGestureRecognizer()
  //               ..onTap = () {
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => null/*RegisterScreen()*/),
  //                 );
  //               })
  //       ]));
  // }
}

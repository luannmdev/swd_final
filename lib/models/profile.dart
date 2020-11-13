import 'package:flutter/cupertino.dart';


class Profile {
   String code;
   String email;
   String fullname;
   String phoneNo;
   String cv;
   double gpa;
   String majorCode;
   String uniCode;
   String majorName;
   String graduation;

  Profile({
    @required this.code,
    @required this.email,
    @required this.fullname,
    @required this.phoneNo,
    @required this.cv,
    @required this.gpa,
    @required this.majorCode,
    @required this.uniCode,
    @required this.majorName,
    @required this.graduation
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      code: json['code'],
      email: json['email'],
      fullname: json['fullname'],
      phoneNo: json['phoneNo'],
      cv: json['cv'],
      gpa: json['gpa'],
      majorCode: json['majorCode'],
      uniCode: json['uniCode'],
      majorName: json['name'],
      graduation: json['graduation']
    );
  }

  Map<String, dynamic> toJson() =>
      {
          "code": this.code,
          "email": this.email,
          "fullname": this.fullname,
          "phoneNo": this.phoneNo,
          "cv": this.cv,
          "gpa": this.gpa,
          "majorCode": this.majorCode,
          "uniCode": this.uniCode,
          "name": this.majorName,
          "graduation": this.graduation
      };
}

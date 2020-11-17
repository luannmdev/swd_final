import 'package:flutter/cupertino.dart';

class CompanyChoose {
  final int id;
  final String compCode;
  final String position;

  CompanyChoose({
    this.id,
    this.compCode,
    this.position,
  });

  factory CompanyChoose.fromJson(Map<String,dynamic> json) {
    return CompanyChoose(
      id: json['id'],
      compCode: json['compCode'],
      position: json['position'],
    );
  }

}

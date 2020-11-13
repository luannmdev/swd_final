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

  static List<CompanyChoose> getCompanies() {
    return <CompanyChoose>[
      CompanyChoose(id: 0, compCode: 'FPT', position: 'C#'),
      CompanyChoose(id: 1, compCode: 'FPT', position: 'JAVA'),
      CompanyChoose(id: 2, compCode: 'FPT3', position: 'JAVA'),
      CompanyChoose(id: 3, compCode: 'FPT4', position: 'C#'),
      CompanyChoose(id: 4, compCode: 'FPT5', position: 'JAVA'),
    ];
  }

  factory CompanyChoose.fromJson(Map<String,dynamic> json) {
    return CompanyChoose(
      id: json['id'],
      compCode: json['compCode'],
      position: json['position'],
    );
  }

}

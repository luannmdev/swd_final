class University{
  String code;
  String email;
  String name;
  String address;
  String phoneNo;
  String description;
  String link;

  University({this.code, this.email, this.name, this.address, this.phoneNo,
      this.description, this.link});

  factory University.fromJson(Map<String,dynamic> json) {
    return University(
      code: json['code'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
      phoneNo: json['phoneNo'],
      description: json['description'],
      link: json['link'],
    );
  }
}



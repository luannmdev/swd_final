class News {
  final int id;
  final String compCode;
  final String majorCode;
  final String position;
  final int quantity;
  final String description;
  final String name;
  final String benefit;
  final String startDate;
  final String endDate;



  News({this.description,this.id,this.compCode, this.majorCode, this.position, this.quantity,this.name, this.benefit,this.startDate,this.endDate});

  factory News.fromJson(Map<String,dynamic> json) {
    return News(
      id: json['id'],
      compCode: json['compCode'],
      majorCode: json['majorCode'],
      position: json['position'],
      quantity: json['quantity'],
      description: json['description'],
      name: json['name'],
      benefit: json['benefit'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }


}
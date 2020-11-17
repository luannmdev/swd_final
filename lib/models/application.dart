class Application {
  final int id;
  final String stuCode;
  final int jobId;
  final String createDate;
  final String status;
  final String acceptDate;



  Application({this.id,this.stuCode,this.jobId, this.createDate, this.status, this.acceptDate});

  factory Application.fromJson(Map<String,dynamic> json) {
    return Application(
      id: json['id'],
      stuCode: json['stuCode'],
      jobId: json['jobId'],
      createDate: json['createDate'],
      status: json['status'],
      acceptDate: json['acceptDate'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": this.id,
        "stuCode": this.stuCode,
        "jobId": this.jobId,
        "createDate": this.createDate,
        "status": this.status,
        "acceptDate": this.acceptDate,
      };
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/university.dart';

class UniScreen extends StatefulWidget {
  University university;

  UniScreen({this.university});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UniScreenState(this.university);
  }
}

class UniScreenState extends State<UniScreen> {
  University university;

  UniScreenState(this.university);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(university.name),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color(0x88999999),
                offset: Offset(0, 5),
                blurRadius: 5.0,
              ),
            ]),
        child: Column(
          children: [
            Text(
              "University Information",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Name: ',style: TextStyle(fontSize: 20),),
                Text(university.name,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Code: ',style: TextStyle(fontSize: 20),),
                Text(university.code,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Address: ',style: TextStyle(fontSize: 20),),
                Text(university.address,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Phone: ',style: TextStyle(fontSize: 20),),
                Text(university.phoneNo,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Link: ',style: TextStyle(fontSize: 20),),
                Text(university.link,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Email: ',style: TextStyle(fontSize: 20),),
                Text(university.email,style: TextStyle(fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Description: ',style: TextStyle(fontSize: 20),),
                Text(university.description,style: TextStyle(fontSize: 20),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

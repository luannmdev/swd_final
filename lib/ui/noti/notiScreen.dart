import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/message.dart';

class NotiPage extends StatefulWidget{
  List<Message> messageNoti;

  NotiPage({this.messageNoti});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotiState(messageNoti);
  }
  
}

class NotiState extends State<NotiPage>{
  List<Message> messageNoti;

  NotiState(this.messageNoti);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: messageNoti.map(buildMessage).toList(),
      ),
    );
  }

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}
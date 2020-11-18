import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/ojt/resultCard.dart';
import 'package:swdprojectbackup/ui/ojt/taskCard.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

class TheResultScreen extends StatefulWidget {
  @override
  _TheResultScreenState createState() => _TheResultScreenState();
}

class _TheResultScreenState extends State<TheResultScreen> {
  List<String> items = ['Company 1', 'Company 2', 'Company 3'];
  List<Color> colors = [Colors.blue[800], Color(0xFFffe5b4), Colors.red];
  List<int> status = [0,0,0];
  Future<List<int>> _future;


  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) async{

      if(!this.mounted) return;
      List<int> temp = await getResult();
      setState(() {
        _future = Future.value(temp);
      });
    });
  }

  Future<List<int>> getResult() async{
    var profileViewModel = Provider.of<ProfileViewModel>(context,listen: false);
    List<Application> temp = await WebService().getAppLastSent(profileViewModel.profile.code,profileViewModel.profile.lastSent);
    List<int> res = new List();
    if (temp.length == 0) {
      res = status;
      return res;
    }
    temp.forEach((element) {
      print(element.id);
      if (element.status == 'Processing') {
        res.add(0);
      }
      if (element.status == 'Approved') {
        res.add(1);
      }
      if (element.status == 'Unapproved') {
        res.add(2);
      }
     });
    if (res.length == 1) {
      res.add(3);
      res.add(3);
    } else if (res.length == 2) {
      res.add(3);
    }
    return res;
  }
  @override
  void initState() {
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).getProfile();
    setUpTimedFetch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.only(topRight: Radius.circular(30.0)),
              color: Color(0xFF00003f),
            ),
          ),
          FutureBuilder<List<int>>(
              future: _future,
              builder: (context, snapshot) {
                // String value = snapshot.data ?? '0';
                List<int> res = snapshot.data ?? status;
                return
                  Padding(
                      padding: const EdgeInsets.only(left: 60.0, top: 30.0,bottom: 30.0),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return ResultCard(
                            number: (index+1).toString(),
                            item: items[index],
                            backgrClr: colors[(index % colors.length)],
                            firstCircle: colors[(index+1) % colors.length],
                            secondCircle: colors[(index+2) % colors.length],
                            statusCard: res[index],
                          );
                        },
                        separatorBuilder: ( BuildContext context, int index ) { return SizedBox(height: 40.0,); },
                        itemCount: items.length,
                      ),
                    );
              }),
          //
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swdprojectbackup/ui/ojt/resultCard.dart';
import 'package:swdprojectbackup/ui/ojt/taskCard.dart';

class TheResultScreen extends StatefulWidget {
  @override
  _TheResultScreenState createState() => _TheResultScreenState();
}

class _TheResultScreenState extends State<TheResultScreen> {
  List<String> items = ['Company 1', 'Company 2', 'Company 3'];
  List<Color> colors = [Colors.blue[800], Color(0xFFffe5b4), Colors.red];
  List<int> status = [0,0,0];

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
                  statusCard: status[index],
                );
              },
              separatorBuilder: ( BuildContext context, int index ) { return SizedBox(height: 40.0,); },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}

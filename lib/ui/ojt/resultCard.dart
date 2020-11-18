import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {

  final String number;
  final String item;
  final Color backgrClr;
  final Color firstCircle;
  final Color secondCircle;
  final int statusCard;

  List<String> status = ['Processing','Pass','Not Pass','-'];
  List<Color> colorStatus = [Colors.blue,Colors.green,Colors.deepOrange,Colors.deepOrange];

  ResultCard({this.number, this.item, this.backgrClr, this.firstCircle, this.secondCircle, this.statusCard});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 80.0,
              decoration: BoxDecoration(
                color: backgrClr,
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                height: 40.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: firstCircle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.0)),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Container(
                height: 40.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: secondCircle,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(60.0)),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 40.0,
          width: 230.0,
          decoration: BoxDecoration(
            color: Color(0xFFffe5b4),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[

                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Color(0xFF00003f),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  status[statusCard],
                  style: TextStyle(
                    fontSize: 15.0,
                    color: colorStatus[statusCard],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
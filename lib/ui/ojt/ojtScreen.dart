import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/ojt/resultScreen.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';
import 'chooseCompViewModel.dart';
import 'updateProfileScreen.dart';
import 'chooseCompScreen.dart';

class OjtScreen extends StatefulWidget {
  final String uniCode;
  final String majorCode;
  final String subject;

  OjtScreen({this.uniCode, this.majorCode, this.subject});

  @override
  _OjtScreenState createState() => _OjtScreenState(uniCode: uniCode,majorCode: majorCode,subject: subject);
}

class _OjtScreenState extends State<OjtScreen> {
  final String uniCode;
  final String majorCode;
  final String subject;

  _OjtScreenState({this.uniCode, this.majorCode, this.subject});


  int selectedIndex = 0;
  List<String> actionStep = ['Update','Choose','The'];
  List<String> actionStepMapping = ['Profile', 'Comp', 'Result'];
  List<bool> statusStep = [false,false,false];

  Widget _updateProfile = UpdateProfileScreen();
  Widget _blank = BlankScreen();


  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._updateProfile;
    } else if(this.selectedIndex == 1) {
      return this._blank;
    } else if(this.selectedIndex == 2) {
      return this._blank;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context,listen: false).getProfile();
    Provider.of<ChooseCompViewModel>(context,listen: false).getCompChoose(uniCode, majorCode, subject);
    print('$uniCode - $majorCode - $subject');
  }

  @override
  Widget build(BuildContext context) {
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    var chooseCompViewModel = Provider.of<ChooseCompViewModel>(context);

    setState(() {
      statusStep[0] = true;
      if (profileViewModel.profile.email == '') {
        statusStep[0] = false;
      }
      if (profileViewModel.profile.phoneNo == '') {
        statusStep[0] = false;
      }
      if (profileViewModel.profile.gpa == null) {
        statusStep[0] = false;
      }
      if (profileViewModel.profile.cv == '') {
        statusStep[0] = false;
      }
    });
    bool statusProfile = false;
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 15.0, top: 30.0, bottom: 50.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          height: 90.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                child: Container(
                                  height: 75.0,
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: index == selectedIndex ? Color(0xFF00003f) :  Color(0xFFffe5b4),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        actionStep[index],
                                        style: TextStyle(
                                            color: index == selectedIndex ? Colors.white : Color(0xFF00003f),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        actionStepMapping[index],
                                        style: TextStyle(
                                            color: index == selectedIndex ? Colors.white: Color(0xFF00003f),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Icon(
                                        statusStep[index] == true ? Icons.check : Icons.warning,
                                        color: statusStep[index] == true ?  Colors.green: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: 25.0,
                              );
                            },
                            itemCount: actionStep.length,
                          ),
                        ),
                      ),
                    ]
                )
              ),

              selectedIndex == 0 ? UpdateProfileScreen() :
              selectedIndex == 1 ? ChooseCompScreen(companiesList: chooseCompViewModel.compList,) : ResultScreen()



            ]
        )

      ),
    );
  }

}


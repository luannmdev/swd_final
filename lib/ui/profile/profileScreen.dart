import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/models/profile.dart';
import 'package:swdprojectbackup/services/google_service.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/login/loginScreen.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

class ProfileScreen extends StatefulWidget {
  final Profile profile;

  ProfileScreen({this.profile});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.profile);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Profile profile;

  _ProfileScreenState(this.profile);

  FocusNode textFieldFocus_fullname;
  FocusNode textFieldFocus_email;
  FocusNode textFieldFocus_phoneNo;
  FocusNode textFieldFocus_gpa;
  FocusNode textFieldFocus_cvLink;
  TextEditingController textController_fullname;
  TextEditingController textController_email;
  TextEditingController textController_phoneNo;
  TextEditingController textController_gpa;
  TextEditingController textController_cvLink;

  Set<int> listEdit = new Set<int>();



  Widget _circleAvatar() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      padding: EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 5),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/avt.jpg'),
        ),
      ),
    );
  }

  Widget _textFormField(
      {id,
      String hintText,
      IconData icon,
        String text,
      bool editable,
      FocusNode focusNode,
      TextEditingController controller}) {
    final int textId = id;
    return Material(
      elevation: 2,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon,color: Theme.of(context).primaryColor,),
          ),
          Container(
            width: 80.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,0),
              child: Text(text, style: TextStyle(color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,)
                    ),
            ),
          ),

          Expanded(
            child: new TextField(
              focusNode: focusNode,
              readOnly: !listEdit.contains(textId),
              controller: controller,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  hintText:  hintText,
                  hintStyle: TextStyle(
                    letterSpacing: 2,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                  filled: true,
                  fillColor: Colors.white30),
            ),
          ),
          if (editable)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print('edit mode');
                setState(() {
                  listEdit.add(textId);
                });
                focusNode.requestFocus();
                print(controller.text);
              },
            )
        ],
      ),
    );
  }

  Widget _textFormFieldCalling() {
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    Profile profile = profileViewModel.profile;
    final bool editable = true;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textFormField(
              id: 0,
              hintText:
                  profile.fullname == null ? 'Full-Name' : profile.fullname,
              icon: Icons.person,
              text: 'Fullname',
              editable: true,
              focusNode: textFieldFocus_fullname,
              controller: textController_fullname),
          SizedBox(height: 3),
          _textFormField(
              id: 1,
              hintText: profile.email == null ? 'E-mail' : profile.email,
              icon: Icons.mail,
              text: 'Email',
              editable: false,
              focusNode: textFieldFocus_email,
              controller: textController_email),
          SizedBox(height: 3),
          _textFormField(
              id: 2,
              hintText:
                  profile.phoneNo == null ? 'Contact Number' : profile.phoneNo,
              icon: Icons.phone,
              text: 'Phone',
              editable: true,
              focusNode: textFieldFocus_phoneNo,
              controller: textController_phoneNo),
          SizedBox(height: 3),
          _textFormField(
              id: 3,
              hintText: profile.gpa == null ? 'GPA' : '${profile.gpa}',
              icon: Icons.person,
              text: 'GPA',
              editable: true,
              focusNode: textFieldFocus_gpa,
              controller: textController_gpa),
          SizedBox(height: 3),
          _textFormField(
              id: 4,
              hintText: profile.cv == null ? 'CV link' : profile.cv,
              icon: Icons.link,
              text: 'CV',
              editable: true,
              focusNode: textFieldFocus_cvLink,
              controller: textController_cvLink),
          SizedBox(height: 3),
          _textFormField(
            id: 5,
            hintText: profile.majorName == null ? 'Major' : profile.majorName,
            text: 'Major',
            icon: Icons.work,
            editable: false,
          ),
          SizedBox(height: 3),
          _textFormField(
            id: 6,
            hintText: profile.graduation == null
                ? 'undergraduate'
                : profile.graduation,
            icon: Icons.grading,
            text: 'Status',
            editable: false,
          ),
          SizedBox(height: 3),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: 55,
            width: 150,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                print('update click');
                textController_fullname.text != ''
                    ? profile.fullname = textController_fullname.text
                    : {};
                textController_gpa.text != ''
                    ? profile.gpa = double.parse(textController_gpa.text)
                    : {};
                textController_phoneNo.text != ''
                    ? profile.phoneNo = textController_phoneNo.text
                    : {};
                textController_cvLink.text != ''
                    ? profile.cv = textController_cvLink.text
                    : {};
                print(profile.toString());
                profileViewModel.updateProfile(profile);
                setState(() {

                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonLogout() {
    return RaisedButton(
      onPressed: () {
        signOutGoogle();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }), ModalRoute.withName('/'));
      },
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Sign Out',
          style: TextStyle(fontSize: 15, color: Colors.red),
        ),
      ),
      // elevation: 5,
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(40)),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('This is message'),
        // action: SnackBarAction(
        //     label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).getProfile();
    // textController_fullname.text = '{profileViewModel.profile.fullname}';
    // textController_email.text = 'aaa';
    // textController_phoneNo.text = '012';
    // textController_gpa.text = '012';
    // textController_cvLink.text = '123';

    textController_fullname = new TextEditingController(text: '${profile.fullname}');
    textController_email = new TextEditingController(text: '${profile.email}');
    textController_phoneNo = new TextEditingController(text: '${profile.phoneNo}');
    textController_gpa = new TextEditingController(text: '${profile.gpa}');
    textController_cvLink = new TextEditingController(text: '${profile.cv}');

    textFieldFocus_fullname = FocusNode();
    textFieldFocus_email = FocusNode();
    textFieldFocus_phoneNo = FocusNode();
    textFieldFocus_gpa = FocusNode();
    textFieldFocus_cvLink = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circleAvatar(),
                _textFormFieldCalling(),
                _buttonLogout(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//Color(0xff555555)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff6361f3);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

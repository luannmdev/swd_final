import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdprojectbackup/models/account.dart';
import 'package:swdprojectbackup/models/profile.dart';
import 'package:swdprojectbackup/services/google_service.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/loadCV/loadCvScreen.dart';
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

  // FocusNode textFieldFocus_email;
  FocusNode textFieldFocus_phoneNo;
  FocusNode textFieldFocus_gpa;
  FocusNode textFieldFocus_cvLink;
  TextEditingController textController_fullname;

  // TextEditingController textController_email;
  TextEditingController textController_phoneNo;
  TextEditingController textController_gpa;
  TextEditingController textController_cvLink;

  Future<String> getPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String photoUrl= prefs.getString('photoUrl');
    return photoUrl;
  }

  Set<int> listEdit = new Set<int>();

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/cover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  Future<String> _future() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString('photoUrl');
  }
  Widget _circleAvatar() {
    return FutureBuilder(
      future: _future(),
      builder: (context, snapshot) => Container(
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
            image: snapshot.hasData ? NetworkImage(snapshot.data) : CircularProgressIndicator(),
          ),
    return FutureBuilder(
      future: getPhoto(),
      builder: (context, snapshot) =>Container(
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
            image: snapshot.hasData ? NetworkImage(snapshot.data) : CircularProgressIndicator(),
          ),
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
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            width: 80.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(text,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Expanded(
            child: new TextField(
              keyboardType: ((id == 3) || (id == 2))
                  ? TextInputType.number
                  : TextInputType.text,
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
                  hintText: hintText,
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
              // hintText:
              //     profile.fullname == null ? 'Full-Name' : profile.fullname,
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
          ),
          // focusNode: textFieldFocus_email,
          // controller: textController_email),
          SizedBox(height: 3),
          _textFormField(
              id: 2,
              // hintText:
              //     profile.phoneNo == null ? 'Contact Number' : profile.phoneNo,
              icon: Icons.phone,
              text: 'Phone',
              editable: true,
              focusNode: textFieldFocus_phoneNo,
              controller: textController_phoneNo),
          SizedBox(height: 3),
          _textFormField(
              id: 3,
              // hintText: profile.gpa == null ? 'GPA' : '${profile.gpa}',
              icon: Icons.person,
              text: 'GPA',
              editable: true,
              focusNode: textFieldFocus_gpa,
              controller: textController_gpa),
          SizedBox(height: 3),
          _textFormField(
              id: 4,
              // hintText: profile.cv == null ? 'CV link' : profile.cv,
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
                    : profile.gpa = 0;
                textController_phoneNo.text != ''
                    ? profile.phoneNo = textController_phoneNo.text
                    : {};
                textController_cvLink.text != 'null'
                    ? profile.cv = textController_cvLink.text
                    : {};
                print(profile.toString());
                profileViewModel.updateProfile(profile);
                // print(profileViewModel.updateStatus);
                // print(LoadingStatus.completed);
                if (profileViewModel.updateStatus == LoadingStatus.completed) {
                  Fluttertoast.showToast(
                      msg: "Update Success",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonLogout() {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.only(bottom: 10),
      child: RaisedButton(
        onPressed: () {
          signOutGoogle();
          Fluttertoast.showToast(
              msg: "Logout",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.yellow,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }), ModalRoute.withName('/'));
        },
        color: Colors.redAccent,
        child: Text(
          'Sign Out',
          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buttonCv() {
    return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 10),
      width: 150,
      height: 50,
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => CvScreen()));
        },
        color: Colors.blue,
        child: Text(
          'Update CV',
          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileViewModel>(context, listen: false).getProfile();
    textController_fullname =
        new TextEditingController(text: '${profile.fullname}');
    textController_phoneNo =
        new TextEditingController(text: '${profile.phoneNo}');
    textController_gpa = new TextEditingController(text: '${profile.gpa}');
    textController_cvLink = profile.cv == 'null'
        ? new TextEditingController()
        : new TextEditingController(text: '${profile.cv}');

    textFieldFocus_fullname = FocusNode();
    textFieldFocus_phoneNo = FocusNode();
    textFieldFocus_gpa = FocusNode();
    textFieldFocus_cvLink = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _buildCoverImage(screenSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _circleAvatar(),
              Container(
                height: MediaQuery.of(context).size.height*0.54,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _textFormFieldCalling(),
                      _buttonCv(),
                      _buttonLogout(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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

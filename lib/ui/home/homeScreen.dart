import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/models/message.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/news/newsScreen.dart';
import 'package:swdprojectbackup/ui/noti/notiScreen.dart';
import 'package:swdprojectbackup/ui/ojt/chooseCompViewModel.dart';
import 'package:swdprojectbackup/ui/ojt/ojtScreen.dart';
import 'package:swdprojectbackup/ui/profile/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

class HomeScreen extends StatelessWidget {
  final List<int> appliedList;

  HomeScreen({this.appliedList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(



        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => NewsListViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProfileViewModel(),
            ),
            ChangeNotifierProvider(
              create: (_) => ChooseCompViewModel(),
            ),
          ],
          child: IndexPage(appliedList: appliedList,),
        ));
  }
}

class IndexPage extends StatefulWidget {
  final List<int> appliedList;

  IndexPage({this.appliedList});
  @override
  State<StatefulWidget> createState() {
    return IndexPageState(appliedList);
  }
}

class IndexPageState extends State<IndexPage> {
  List<int> appliedList;
  PageController pageController;
  int _selectedIndex = 0;
  Widget _myReport = BlankScreen();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  bool disableApplyJob;

  IndexPageState(this.appliedList);

  @override
  void initState() {
    // print('appliedList - ${appliedList.length}');
    if (disableApplyJob == null) {
      disableApplyJob= false;
    }
    if(appliedList == null) {
      appliedList = new List();
    }
    pageController = PageController();
    Provider.of<ProfileViewModel>(context, listen: false).getProfile();
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
          _showNoti(context);
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onDataChange(List<int> newAppliedList) {
    setState(() => appliedList = newAppliedList);
    print('test thanh cong ${appliedList.toString()}');
  }

  void onStatusChange(bool status) {
    setState(() => disableApplyJob = status);
    print('test thanh cong ${disableApplyJob.toString()}');
  }

  void onTapHandler(int index) {
    this.setState(() {
      this._selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  void onClickNoti(BuildContext context, List<Message> list) {
    if (list.length >= 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotiPage(messageNoti: messages,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    if ((profileViewModel.profile.lastSent != 0)&&(profileViewModel.profile.lastSent != null)) {
      disableApplyJob = true;

    }
    final key = GlobalKey<State<BottomNavigationBar>>();
    if (!profileViewModel.loadingStatus) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: GradientAppBar(
          // backgroundColor: Color(0xFFf75205),
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
          automaticallyImplyLeading: false,
          title: Text("OJT PROJECT"),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
                  onClickNoti(context, messages);
                  // do something
                })
          ],
        ),
        body: WillPopScope(
            onWillPop: _onWillPop,
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                NewsScreen(
                      disableApplyJob,
                      appliedList,
                      profileViewModel.profile.uniCode,
                      profileViewModel.profile.majorCode,
                      profileViewModel.profile.graduation,
                    profileViewModel.profile.code,
                      onDataChange,
                      profileViewModel.profile.lastSent
                ),
                OjtScreen(
                      appliedList: appliedList,
                      uniCode: profileViewModel.profile.uniCode,
                      majorCode: profileViewModel.profile.majorCode,
                      subject: profileViewModel.profile.graduation,
                      onDataChange: onDataChange,
                      onStatusChange: onStatusChange,
                      disableApplyJob: disableApplyJob,
                    ),

                BlankScreen(),
                ProfileScreen(
                      profile: profileViewModel.profile,
                    )
              ],
            ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          key: key,
          type: BottomNavigationBarType.fixed,
          currentIndex: this._selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Index"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text("OJT"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              title: Text("Report"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
            )
          ],
          onTap: (int index) async {
            this.onTapHandler(index);
          },
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    };
  }

  // Widget getBody() {
  //   var profileViewModel = Provider.of<ProfileViewModel>(context);
  //   if (!profileViewModel.loadingStatus) {
  //     if (this._selectedIndex == 0) {
  //       return WillPopScope(
  //           onWillPop: _onWillPop,
  //           child: NewsScreen(
  //               appliedList,
  //               profileViewModel.profile.uniCode,
  //               profileViewModel.profile.majorCode,
  //               profileViewModel.profile.graduation));
  //     } else if (this._selectedIndex == 1) {
  //       return WillPopScope(
  //           onWillPop: _onWillPop,
  //           child: OjtScreen(
  //             uniCode: profileViewModel.profile.uniCode,
  //             majorCode: profileViewModel.profile.majorCode,
  //             subject: profileViewModel.profile.graduation,
  //           ));
  //     } else if (this._selectedIndex == 2) {
  //       return this._myReport;
  //     } else {
  //       return WillPopScope(
  //           onWillPop: _onWillPop,
  //           child: ProfileScreen(
  //             profile: profileViewModel.profile,
  //           ));
  //     }
  //   }
  // }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Future _showNoti(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text('You have a notification!'),
          actions: [
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

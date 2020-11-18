import 'package:flutter/material.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/news/newsScreen.dart';
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


  @override
  Widget build(BuildContext context) {
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    if ((profileViewModel.profile.lastSent != 0)&&(profileViewModel.profile.lastSent != null)) {
      disableApplyJob = true;

    }
    final key = GlobalKey<State<BottomNavigationBar>>();
    if (!profileViewModel.loadingStatus) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("OJT PROJECT"),
          actions: <Widget>[
            new IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
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
}

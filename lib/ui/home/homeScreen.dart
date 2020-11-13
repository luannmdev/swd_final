import 'package:flutter/material.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/news/newsScreen.dart';
import 'package:swdprojectbackup/ui/ojt/chooseCompViewModel.dart';
import 'package:swdprojectbackup/ui/ojt/ojtScreen.dart';
// import 'package:swdprojectbackup/ui/newsdetail/newsDetailScreen.dart';
// import 'package:swdprojectbackup/ui/ojt/ojtScreen.dart';
import 'package:swdprojectbackup/ui/profile/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OJT PROJECT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
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
        child: IndexPage(),
      )
    );
  }
}

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IndexPageState();
  }

}

RelativeRect buttonMenuPosition(BuildContext c) {
  final RenderBox bar = c.findRenderObject();
  final RenderBox overlay = Overlay.of(c).context.findRenderObject();
  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(
      bar.localToGlobal(bar.size.bottomRight(Offset.zero), ancestor: overlay),
      bar.localToGlobal(bar.size.bottomRight(Offset.zero), ancestor: overlay),
    ),
    Offset.zero & overlay.size,
  );
  return position;
}
//Positioned(right: 0, bottom: bottomAppBarHeight)

class IndexPageState extends State<IndexPage> {
  int selectedIndex = 0;
  // Widget _myIndex = NewsScreen();
  // Widget _myOJT = OjtScreen();
  // Widget _myReport = BlankScreen();
  // Widget _myProfile = ProfileScreen();

  // Widget _myIndex = NewsScreen();
  // Widget _myOJT = OjtScreen();
  Widget _myReport = BlankScreen();
  // Widget _myProfile = ProfileScreen();

  @override
  void initState() {
    Provider.of<ProfileViewModel>(context,listen: false).getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<BottomNavigationBar>>();
    return Scaffold(
      appBar: AppBar(
        title: Text("OJT PROJECT"),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.notifications_active),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewsDetailPage()),
                // );
              }
          )
        ],
      ),
      body:  this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        key: key,
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
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
          // final position = buttonMenuPosition(key.currentContext);
          // if (index == 3) {
          //   final result = await showMenu(
          //     context: context,
          //     position: position,
          //     items: <PopupMenuItem<String>>[
          //       const PopupMenuItem<String>(
          //           child: Text('test1'), value: 'test1'),
          //       const PopupMenuItem<String>(
          //           child: Text('test2'), value: 'test2'),
          //     ],
          //   );
          // } else {
          //   this.onTapHandler(index);
          // }
        },
      ),
    );
  }

  Widget getBody()  {
    var  profileViewModel = Provider.of<ProfileViewModel>(context);
    if (!profileViewModel.loadingStatus) {
      if (this.selectedIndex == 0) {
        return NewsScreen(profileViewModel.profile.uniCode,profileViewModel.profile.majorCode,profileViewModel.profile.graduation);
      } else if(this.selectedIndex == 1) {
        return OjtScreen(uniCode: profileViewModel.profile.uniCode,majorCode: profileViewModel.profile.majorCode,subject: profileViewModel.profile.graduation,);
      } else if(this.selectedIndex == 2) {
        return this._myReport;
      } else {
        return ProfileScreen(profile: profileViewModel.profile,);
      }
    }

  }

  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
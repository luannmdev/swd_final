import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailScreen.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailViewModel.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

import 'newsViewModel.dart';

class NewsScreen extends StatefulWidget {
  bool disableApplyJob;
  List<int> appliedList;
  String _uniCode;
  String _majorCode;
  String _subject;
  String _code;
  final Function(List<int>) onDataChange;
  final int lastSent;

  NewsScreen(disableApplyJob,appliedList, @required uniCode, @required majorCode, @required subject, code, this.onDataChange,this.lastSent) {
    this.disableApplyJob = disableApplyJob;
    this.appliedList = appliedList;
    this._subject = subject;
    this._uniCode = uniCode;
    this._majorCode = majorCode;
    this._code = code;
  }

  @override
  _NewsScreenState createState() =>
      _NewsScreenState(disableApplyJob,appliedList,_uniCode, _majorCode, _subject,_code, onDataChange,lastSent);
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;
  bool disableApplyJob;
  final Function(List<int>) onDataChange;
  final int lastSent;
  List<int> appliedList;
  String _uniCode;
  String _majorCode;
  String _subject;
  String _code;
  int pageCount = 1;

  _NewsScreenState(disableApplyJob,appliedList,@required uniCode, @required majorCode, @required subject, code, this.onDataChange,this.lastSent) {
    this.disableApplyJob = disableApplyJob;
    this.appliedList = appliedList;
    this._uniCode = uniCode;
    this._majorCode = majorCode;
    this._subject = subject;
    this._code = code;
  }

  void updateListApp(List<Application> list) {
    if((disableApplyJob) && (list.length > 0))
    setState(() {
      appliedList.clear();
      list.forEach((element) {
        appliedList.add(element.jobId);
      });
      onDataChange(appliedList);
      print('app list updated: ${appliedList.toString()}');
    });
  }

  @override
  void initState() {
    print('NEWSSCREEN DISABLE = $disableApplyJob');
    Provider.of<NewsListViewModel>(context, listen: false)
        .topHeadlines(pageCount, _uniCode, _majorCode, _subject);
    _getListApplicationLastSent(_code, lastSent).then((list) => {
      updateListApp(list)
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var listViewModel = Provider.of<NewsListViewModel>(context);
    var profileViewModel = Provider.of<ProfileViewModel>(context);
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 40,
            right: 20,
            bottom: 40,
          ),
          child: Text(
            'Hi, Test1, ${listViewModel.articlesList.length}',
            style: TextStyle(fontSize: 50.0),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white70,
                  toolbarHeight: 50,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Your Saved'),
                      Tab(
                          icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    _newsViews(),
                    _savedViews(),
                    Icon(Icons.search),
                  ],
                )),
          ),
        ),
      ],
    ));
  }

  Widget _newsViews() {
    var listViewModel = Provider.of<NewsListViewModel>(context);
    return listViewModel.loadingStatus.toString() == 'LoadingStatus.searching'
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: listViewModel.articlesList.length,
            itemBuilder: (context, index) {

              if (index >= (listViewModel.articlesList.length - 1)
                  &&(listViewModel.articlesList.length == (pageCount*10))) {
                print('next page');
                pageCount++;
                Provider.of<NewsListViewModel>(context, listen: false)
                    .topHeadlines(pageCount, _uniCode, _majorCode, _subject);
                listViewModel = Provider.of<NewsListViewModel>(context);
                print('newsLength = ${listViewModel.articlesList.length}');
                print('pageCount = $pageCount');
                print('itemsCount*10 = ${pageCount*10}');
              }
              return _buildRow(
                  listViewModel.articlesList[index].compCode +
                      ' need ' +
                      '${listViewModel.articlesList[index].quantity}' +
                      ' in ' +
                      listViewModel.articlesList[index].name +
                      ' - ' +
                      listViewModel.articlesList[index].position,
                  listViewModel.articlesList[index].id);
            });
  }

  Widget _savedViews() {
    var listViewModel = Provider.of<NewsListViewModel>(context);
    List<NewsViewModel> savedList = new List();
    return listViewModel.loadingStatus.toString() == 'LoadingStatus.searching'
        ? CircularProgressIndicator()
        : ListView.builder(
        itemCount: appliedList.length,
        itemBuilder: (context, index) {
          listViewModel.articlesList.forEach((element) {
            if (appliedList.contains(element.id)){
              savedList.add(element);
            }
          });
          return _buildRow(
              savedList[index].compCode +
                  ' need ' +
                  '${savedList[index].quantity}' +
                  ' in ' +
                  savedList[index].name +
                  ' - ' +
                  savedList[index].position,
              savedList[index].id);
        });
  }

  Widget _buildRow(String title, int id) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0),
      ),
      trailing: new Icon(
        Icons.read_more,
        color: Colors.red,
      ),
      onTap: () async{
        print('tap tap');
        var tmp = await Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => NewsDetailViewModel(),
                        ),
                      ],
                      child: new NewsDetailScreen(
                        disableApplyJob: disableApplyJob,
                        appliedList: appliedList,
                        idNews: id,
                      ))),
        );
        onDataChange(tmp);
      },
    );
  }
}
Future<List<Application>> _getListApplicationLastSent(String stuCode, int lastSent) async{
  return await WebService().getAppLastSent(stuCode, lastSent);
}

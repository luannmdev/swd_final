import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailScreen.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailViewModel.dart';
import 'package:swdprojectbackup/ui/profile/profileViewModel.dart';

class NewsScreen extends StatefulWidget {
  String _uniCode;
  String _majorCode;
  String _subject;

  NewsScreen(@required uniCode, @required majorCode, @required subject) {
    this._subject = subject;
    this._uniCode = uniCode;
    this._majorCode = majorCode;
  }

  @override
  _NewsScreenState createState() =>
      _NewsScreenState(_uniCode, _majorCode, _subject);
}

class _NewsScreenState extends State<NewsScreen> {
  String _uniCode;
  String _majorCode;
  String _subject;
  int itemsCount = 10;

  _NewsScreenState(@required uniCode, @required majorCode, @required subject) {
    this._uniCode = uniCode;
    this._majorCode = majorCode;
    this._subject = subject;
  }

  @override
  void initState() {
    Provider.of<NewsListViewModel>(context, listen: false)
        .topHeadlines(1, _uniCode, _majorCode, _subject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    Icon(Icons.directions_transit),
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
              print('$index - $itemsCount - ${listViewModel.articlesList.length}');

              if (index >= (listViewModel.articlesList.length - 1)) {
                print('next page');
                Provider.of<NewsListViewModel>(context, listen: false)
                    .topHeadlines(2, _uniCode, _majorCode, _subject);
                listViewModel = Provider.of<NewsListViewModel>(context);
                itemsCount = listViewModel.articlesList.length;


              }
              // print('$index - ${listViewModel.articlesList.length}');
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
      onTap: () {
        print('tap tap');
        Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => NewsDetailViewModel(),
                        ),
                      ],
                      child: new NewsDetailScreen(
                        idNews: id,
                      ))),
        );
      },
    );
  }
}

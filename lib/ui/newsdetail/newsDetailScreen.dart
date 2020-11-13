import 'package:flutter/material.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/home/homeScreen.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/news/newsScreen.dart';
// import 'package:swdprojectbackup/ui/profile/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailViewModel.dart';

class NewsDetailScreen extends StatelessWidget {
  final int idNews;
  NewsDetailScreen({Key key, @required this.idNews}) : super(key: key);

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
            )
          ],
          child: NewsDetailPage(idNews: idNews),
        ));
  }
}

class NewsDetailPage extends StatefulWidget {
  final int idNews;
  NewsDetailPage({Key key, @required this.idNews}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsDetailPageState(idNews);
  }
}

class NewsDetailPageState extends State<NewsDetailPage> {
  final int idNews;
  NewsDetailPageState(this.idNews);

  @override
  void initState() {
    Provider.of<NewsDetailViewModel>(context, listen: false)
        .getNewsDetailById(idNews);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<NewsDetailViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
      ),
      body: viewModel.loadingStatus
          ? CircularProgressIndicator()
          : _newsDetailViews(),
    );
  }

  Widget _newsDetailViews() {
    var viewModel = Provider.of<NewsDetailViewModel>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          children: [
            Text(
              viewModel.article.compCode +
                  ' need ' +
                  '${viewModel.article.quantity}' +
                  ' in ' +
                  viewModel.article.name +
                  ' - ' +
                  viewModel.article.position +
                  '.',
              style:
                  const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 10.0),
              child: Text(
                viewModel.article.description,
                style:
                const TextStyle(fontSize: 20.0, ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 10.0),
              child: Material(
                elevation: 2,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:[
                      Row(
                          children:[
                            Text(
                              'Benefit: ',
                              style:const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              viewModel.article.benefit,
                              style:const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.left,
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Text(
                              'Date start: ',
                              style:const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              viewModel.article.startDate,
                              style:const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.left,
                            ),
                          ]
                      ),
                      Row(
                          children:[
                            Text(
                              'Date end: ',
                              style:const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              viewModel.article.endDate,
                              style:const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.left,
                            ),
                          ]
                      ),
                    ]
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: 55,
              width: 150,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Apply Job',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  print('appply job');

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

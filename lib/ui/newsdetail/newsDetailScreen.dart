import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swdprojectbackup/ui/blank/blankScreen.dart';
import 'package:swdprojectbackup/ui/home/homeScreen.dart';
import 'package:swdprojectbackup/ui/news/newsListViewModel.dart';
import 'package:swdprojectbackup/ui/news/newsScreen.dart';
// import 'package:swdprojectbackup/ui/profile/profileScreen.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/ui/news/newsViewModel.dart';
import 'package:swdprojectbackup/ui/newsdetail/newsDetailViewModel.dart';

class NewsDetailScreen extends StatelessWidget {
  final bool disableApplyJob;
  final List<int> appliedList;
  final int idNews;
  NewsDetailScreen(
      {Key key, this.disableApplyJob, this.appliedList, @required this.idNews})
      : super(key: key);

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
        )
      ],
      child: NewsDetailPage(
          disableApplyJob: disableApplyJob,
          appliedList: appliedList,
          idNews: idNews),
    ));
  }
}

class NewsDetailPage extends StatefulWidget {
  final bool disableApplyJob;
  final List<int> appliedList;
  final int idNews;
  NewsDetailPage(
      {Key key, this.disableApplyJob, this.appliedList, @required this.idNews})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsDetailPageState(disableApplyJob, appliedList, idNews);
  }
}

class NewsDetailPageState extends State<NewsDetailPage> {
  final bool disableApplyJob;
  List<int> appliedList;
  final int idNews;
  String textButton = 'Apply Job';
  Color colorButton = Colors.blue;
  NewsDetailPageState(this.disableApplyJob, this.appliedList, this.idNews);

  @override
  void initState() {
    Provider.of<NewsDetailViewModel>(context, listen: false)
        .getNewsDetailById(idNews);
    super.initState();
    print('DETAIL DISABLE = $disableApplyJob');
  }

  @override
  Widget build(BuildContext context) {
    if (appliedList == null) {
      appliedList = new List();
    }
    var viewModel = Provider.of<NewsDetailViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, appliedList);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomeScreen(appliedList: appliedList,)),
              // );
            }),
      ),
      body: viewModel.loadingStatus
          ? CircularProgressIndicator()
          : _newsDetailViews(),
    );
  }

  Widget _buttonRemoveJob(NewsViewModel article) {
    return RaisedButton(
      disabledColor: Colors.grey,
      color: Colors.orange,
      child: Center(
        child: Text(
          'Remove Job',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: disableApplyJob
          ? null
          : () {
              print('remove job');
              setState(() {
                appliedList.remove(article.id);
              });
              Fluttertoast.showToast(
                  msg: "Removed from applies list",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
    );
  }

  Widget _buttonAddJob(NewsViewModel article) {
    return RaisedButton(
      disabledColor: Colors.grey,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Apply Job',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: disableApplyJob
          ? null
          : () {
              print('apply job ${appliedList.length}');
              if (appliedList.length == 3) {
                Fluttertoast.showToast(
                    msg:
                        "Your list job has been full - ${appliedList.length}/3",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.orange,
                    fontSize: 16.0);
              } else if (!appliedList.contains(article)) {
                setState(() {
                  appliedList.add(article.id);
                });
                Fluttertoast.showToast(
                    msg: "Added to applies list - ${appliedList.length}/3",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
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
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
              child: Text(
                viewModel.article.description,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
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
                  child: Column(children: [
                    Row(children: [
                      Text(
                        'Benefit: ',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        viewModel.article.benefit,
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      ),
                    ]),
                    Row(children: [
                      Text(
                        'Date start: ',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        viewModel.article.startDate,
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      ),
                    ]),
                    Row(children: [
                      Text(
                        'Date end: ',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        viewModel.article.endDate,
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      ),
                    ]),
                    Row(children: [
                      Text(
                        'Applied List: ',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        appliedList.toString(),
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.left,
                      ),
                    ]),
                  ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: 55,
              width: 150,
              child: appliedList.contains(viewModel.article.id)
                  ? _buttonRemoveJob(viewModel.article)
                  : _buttonAddJob(viewModel.article),
            ),
          ],
        ),
      ),
    );
  }
}

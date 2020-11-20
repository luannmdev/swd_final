// import 'dart:io';
// // import 'package:erusmobile/constrants/app_constrants.dart';
// // import 'package:erusmobile/scr/blocs/load_pdf_bloc.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:path_provider/path_provider.dart';
//
// class LaunchFile {
//   static void launchPDF({BuildContext context, String title, String file}) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PDFScreen(title, file),
//         ));
//   }
//
//   static Future<dynamic> loadFromFirebase(
//       BuildContext context, String url) async {
//     return FireStorageService.loadFromStorage(context, url);
//   }
//
//   static Future<dynamic> createFileFromPdfUrl(dynamic url) async {
//     final filename = 'cvuser.pdf';
//     print(filename);
//     var request = await HttpClient().getUrl(Uri.parse(url));
//     var response = await request.close();
//     var bytes = await consolidateHttpClientResponseBytes(response);
//     String dir = (await getApplicationDocumentsDirectory()).path;
//     File file = new File('$dir/$filename');
//     await file.writeAsBytes(bytes);
//     return file;
//   }
// }
//
// class FireStorageService extends ChangeNotifier {
//   FireStorageService._();
//
//   FireStorageService();
//
//   static Future<dynamic> saveToStorage(File file, String filename) async {
//     return await FirebaseStorage.instance
//         .ref()
//         .child(filename)
//         .putFile(file)
//         .onComplete;
//   }
//
//   static Future<dynamic> loadFromStorage(
//       BuildContext context, String file) async {
//     return await FirebaseStorage.instance.ref().child(file).getDownloadURL();
//   }
// }
//
// // ignore: must_be_immutable
// class PDFScreen extends StatefulWidget {
//   String title;
//   String file;
//
//   PDFScreen(this.title, this.file);
//
//   @override
//   _PDFScreenState createState() => _PDFScreenState();
// }
//
// class _PDFScreenState extends State<PDFScreen> {
//   final bloc = PDFFileBloc();
//
//   @override
//   Widget build(BuildContext context) {
//     bloc.getPath(context, widget.file);
//     return Scaffold(
//         resizeToAvoidBottomPadding: false,
//         body: StreamBuilder(
//           stream: bloc.pathPDF,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               String pathPDF = snapshot.data.toString();
//               return PDFViewerScaffold(
//                 appBar: AppBar(
//                   automaticallyImplyLeading: false,
//                   leading: BackButton(),
//                   backgroundColor: AppThemes.theme_color,
//                   title: Text('Resume'),
//                   actions: <Widget>[
//                   ],
//                 ),
//                 path: pathPDF,
//               );
//             }
//             return Center(child: CircularProgressIndicator());
//           },
//         ));
//   }
// }

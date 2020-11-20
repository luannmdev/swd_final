import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swdprojectbackup/services/launch_pdf.dart';

import 'PDFScreen.dart';
import 'filePicker.dart';

final Color cyan = Colors.cyan;
final Color blue = Colors.blue;

String file = "cv/cvuser.pdf";
String fileName = "CV";

class LoadFirbaseStoragePdf extends StatefulWidget {
  @override
  _LoadFirbaseStoragePdfState createState() => _LoadFirbaseStoragePdfState();
}

class _LoadFirbaseStoragePdfState extends State<LoadFirbaseStoragePdf> {
  static String pathPDF = "";
  static String pdfUrl = "";

  @override
  void initState() {
    super.initState();

    //Fetch file from FirebaseStorage first
    LaunchFile.loadFromFirebase(context, file)
    //Creating PDF file at disk for ios and android & assigning pdf url for web
        .then((url) => LaunchFile.createFileFromPdfUrl(url).then(
          (f) => setState(
            () {
          if (f is File) {
            pathPDF = f.path;
            print(pathPDF);
          } else if (url is Uri) {
            pdfUrl = url.toString();
          }
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('CV'),

      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(
                    colors: [blue, cyan],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Loading Slides PDF from Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                openPDFButton(context),
                SizedBox(height: 10.0),
                uploadPDFButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadPDFButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                 left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cyan, blue],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () async {
                 // pickFileChooser().then((value) => {
                 //   if (value is File) {
                 //     print('aasaaaaaaaaaaaaaaaaaaaa FILE')
                 //   }
                 // });
              },
              child: Text(
                "Upload CV",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget openPDFButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cyan, blue],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () {
                setState(() {
                  LaunchFile.launchPDF(
                      context, "Your CV On Firebase", pathPDF, pdfUrl);
                });
              },
              child: Text(
                "Open CV",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Future<File> pickFileChooser() async {
//   File result = await FilePicker.getFile(
//     type: FileType.CUSTOM,
//     fileExtension: 'pdf',
//   );
//
//   if (result != null) {
//     File file = result;
//     return file;
//   } else {
//     // User canceled the picker
//     return null;
//   }
// }
// Future<File> chooseFile() async {
//   FilePickerResult result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf'],
//   );
//   if (result != null) {
//     File file = File(result.files.single.path);
//     return file;
//   } else {
//     return null;
//   }
// }
import 'dart:io';

import 'package:file_picker/file_picker.dart';
//
//
// Future<File> pickFileChooser() async {
//   FilePickerResult result = await FilePicker.platform.pickFiles();
//   if (result != null) {
//     File file = File(result.files.single.path);
//     return file;
//   } else {
//     // User canceled the picker
//     return null;
//   }
// }

Future<File> pickFileChooser() async{
  File result = await FilePicker.getFile(type: FileType.CUSTOM, fileExtension: 'pdf');
  if(result != null){
    return result;
  }else{
    return null;
  }
}
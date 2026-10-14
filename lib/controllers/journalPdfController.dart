import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Journalpdfcontroller {

  Future<String> getFileLocation() async{
    final dir = Directory('${(Platform.isAndroid
      ? await getExternalStorageDirectory() //FOR ANDROID
      : await getApplicationSupportDirectory() //FOR IOS
      )!
        .path}/RBC_APP');
    return dir.path;
  }
  
}
import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';

class FileProvider with ChangeNotifier {
  List<UIFile> _uiFiles = List();

  updateFile(int index, UIFile uiFile) {
    _uiFiles[index] = uiFile;
    notifyListeners();
  }

  setFiles(List<UIFile> uiFiles) {
    _uiFiles = uiFiles;
    notifyListeners();
  }

  List<UIFile> get uiFiles => _uiFiles;
}

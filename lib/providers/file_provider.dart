import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';
import 'package:flutter_finder/ui/components/file_explorer.dart';
import 'package:flutter_finder/ui/components/previews/file_preview.dart';
import 'package:flutter_finder/ui/components/side_bar.dart';
import 'package:flutter_finder/utils/file_manager.dart';
import 'package:path/path.dart' as p;

class FileProvider with ChangeNotifier {
  List<UIFile> _uiFiles = List();
  String _path = '/';

  updatePath(BuildContext context, String path) {
    _path = path;
    _listFiles(context);
  }

  updateFile(int index, UIFile uiFile) {
    if (_uiFiles.length > index) {
      _uiFiles[index] = uiFile;
      notifyListeners();
    }
  }

  setFiles(List<UIFile> uiFiles) {
    _uiFiles = uiFiles;
    notifyListeners();
  }

  selectFile(int index) {
    if (_uiFiles.length > index) {
      // Unselected all files
      for (var uiFile in _uiFiles.where((element) => element.isSelected)) {
        uiFile.isSelected = false;
      }

      // Select the file
      _uiFiles[index].isSelected = true;
      notifyListeners();
    }
  }

  _listFiles(BuildContext context) async {
    var size = MediaQuery.of(context).size;
    var uiFiles = List<UIFile>();
    var nbLines = 0;
    var index = 0;

    Directory dir = Directory(_path);
    var files = dir.listSync();

    for (var file in files) {
      double x = index * COLUMN_SPACE;
      double y = nbLines * LINE_SPACE;

      // Set the position in X, Y
      if (x >= size.width - SIDE_BAR_SPACE - FILE_PREVIEW_WIDTH) {
        index = 0;
        nbLines++;
        y = nbLines * LINE_SPACE;
        x = 0;
      }

      // Define the icon, name and if it is a folder
      var fileName = p.basename(file.path);
      var iconPath = "assets/file.png";
      var isFolder = FileSystemEntity.isDirectorySync(file.path);

      if (isFolder) {
        if (file.path == await FileManager().getApplicationPath()) {
          iconPath = "assets/folder_application.png";
        } else if (file.path == await FileManager().getDesktopPath()) {
          iconPath = "assets/folder_desktop.png";
        } else if (file.path == await FileManager().getDocumentPath()) {
          iconPath = "assets/folder_documents.png";
        } else if (file.path == await FileManager().getDownloadPath()) {
          iconPath = "assets/folder_download.png";
        } else if (file.path == await FileManager().getHomePath()) {
//          iconPath = "assets/folder_download.png"; // TODO: Add the icon
        } else {
          iconPath = "assets/folder.png";
        }
      }

      if (fileName[0] != '.') {
        var uiFile = UIFile(
          fileSystemEntity: file,
          x: x,
          y: y,
          isSelected: false,
          isFolder: isFolder,
          iconPath: iconPath,
        );

        uiFiles.add(uiFile);

        index++;
      }
    }

    _uiFiles = uiFiles;
    notifyListeners();
  }

  List<UIFile> get uiFiles => _uiFiles;

  String get path => _path;
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/ui/components/file_explorer.dart';
import 'package:flutter_finder/ui/components/previews/file_preview.dart';
import 'package:flutter_finder/ui/components/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FileProvider _fileProvider;
  String _path = '/Users/lazyos';

  _listFiles() async {
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

      var fileName = path.basename(file.path);

      if (fileName[0] != '.') {
        var uiFile = UIFile(
          fileSystemEntity: file,
          x: x,
          y: y,
          isSelected: false,
        );

        uiFiles.add(uiFile);

        index++;
      }
    }

    _fileProvider.setFiles(uiFiles);
  }

  @override
  Widget build(BuildContext context) {
    _fileProvider = Provider.of<FileProvider>(context, listen: true);

    if (_fileProvider.uiFiles.isEmpty) {
      _listFiles();
    }

    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: FileExplorer(),
          ),
        ],
      ),
    );
  }
}

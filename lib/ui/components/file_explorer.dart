import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/ui/components/previews/file_preview.dart';
import 'package:path/path.dart' as path;

class FileExplorer extends StatefulWidget {
  FileExplorer({
    @required this.fileEntities,
  });

  final List<FileSystemEntity> fileEntities;

  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  List<Widget> _generateElements() {
    List<Widget> elements = List();
    var size = MediaQuery.of(context).size;
    var nbLines = 0;
    var index = 0;

    // Displays each files and folders
    for (var element in widget.fileEntities) {
      double x = index * 110.0;
      double y = nbLines * 90.0;

      // Set the position in X, Y
      if (x >= size.width - 300) {
        index = 0;
        nbLines++;
        y = nbLines * 70.0;
        x = 0;
      }

      // Only displays visible files
      var fileName = path.basename(element.path);

      if (fileName[0] != '.') {
        var icon = Icons.insert_drive_file;

        if (FileSystemEntity.isDirectorySync(element.path)) {
          icon = Icons.folder;
        }

        var filePreview = FilePreview(
          name: fileName,
          icon: icon,
          x: x,
          y: y,
        );
        elements.add(filePreview);
        index++;
      }


    }

    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Stack(
        children: _generateElements(),
      ),
    );
  }
}

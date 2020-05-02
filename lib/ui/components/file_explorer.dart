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

    for (var element in widget.fileEntities) {
      // Only displays visible files
      var fileName = path.basename(element.path);

      if (fileName[0] != '.') {
        if (FileSystemEntity.isDirectorySync(element.path)) {
          var filePreview = FilePreview(
            name: fileName,
            icon: Icons.folder,
          );
          elements.add(filePreview);
        } else {
          var filePreview = FilePreview(
            name: fileName,
            icon: Icons.insert_drive_file,
          );
          elements.add(filePreview);
        }
      }
    }

    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: GridView.count(
        crossAxisCount: 6,
        children: _generateElements(),
      ),
    );
  }
}

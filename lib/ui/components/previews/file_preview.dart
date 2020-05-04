import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../side_bar.dart';

const FILE_PREVIEW_WIDTH = 100.0;
const FILE_PREVIEW_HEIGHT = 70.0;

class FilePreview extends StatefulWidget {
  FilePreview({
    this.uiFile,
  });

  final UIFile uiFile;

  @override
  _FilePreviewState createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  FileProvider _fileProvider;

  Widget _displayWidget() {
    var icon = Icons.insert_drive_file;
    var isFolder =
        FileSystemEntity.isDirectorySync(widget.uiFile.fileSystemEntity.path);

    if (isFolder) {
      icon = Icons.folder;
    }

    return Container(
      width: FILE_PREVIEW_WIDTH,
      height: FILE_PREVIEW_HEIGHT,
      decoration: widget.uiFile.isSelected
          ? BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.all(Radius.circular(8)),
            )
          : null,
      child: GestureDetector(
        onPanStart: (DragStartDetails details) {
          // Select file / folder
          var index = _fileProvider.uiFiles.indexOf(widget.uiFile);
          _fileProvider.selectFile(index);
        },
        onPanUpdate: (DragUpdateDetails details) {
          // Move file / folder
          var index = _fileProvider.uiFiles.indexOf(widget.uiFile);
          var uiFile = widget.uiFile;
          uiFile.x = details.globalPosition.dx -
              SIDE_BAR_SPACE -
              (FILE_PREVIEW_WIDTH / 2);
          uiFile.y = details.globalPosition.dy - (FILE_PREVIEW_HEIGHT / 2);
          _fileProvider.updateFile(index, uiFile);
        },
        onDoubleTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                icon,
                color: Colors.indigo,
                size: 50,
              ),
            ),
            Container(
              width: FILE_PREVIEW_WIDTH,
              child: Text(
                path.basename(widget.uiFile.fileSystemEntity.path),
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fileProvider = Provider.of<FileProvider>(context, listen: true);

    return Positioned(
      left: widget.uiFile.x,
      top: widget.uiFile.y,
      child: _displayWidget(),
    );
  }
}

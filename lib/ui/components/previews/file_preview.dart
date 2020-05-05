import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../side_bar.dart';

const FILE_PREVIEW_WIDTH = 110.0;
const FILE_PREVIEW_HEIGHT = 90.0;

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
        onTap: () {
          var index = _fileProvider.uiFiles.indexOf(widget.uiFile);
          _fileProvider.selectFile(index);
        },
        onDoubleTap: () {
          if(widget.uiFile.isFolder) {
            _fileProvider.updatePath(context, _fileProvider.path + "/" + path.basename(widget.uiFile.fileSystemEntity.path));
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image.asset(
                widget.uiFile.iconPath,
              ),
            ),
            Container(
              width: FILE_PREVIEW_WIDTH,
              child: Text(
                path.basename(widget.uiFile.fileSystemEntity.path),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
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

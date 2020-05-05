import 'package:flutter/material.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/ui/components/previews/file_preview.dart';
import 'package:provider/provider.dart';

const LINE_SPACE = 100.0;
const COLUMN_SPACE = 110.0;

class FileExplorer extends StatefulWidget {
  @override
  _FileExplorerState createState() => _FileExplorerState();
}

class _FileExplorerState extends State<FileExplorer> {
  FileProvider _fileProvider;

  List<Widget> _generateElements() {
    List<Widget> elements = List();

    // Displays each files and folders
    for (var element in _fileProvider.uiFiles) {
      elements.add(FilePreview(uiFile: element));
    }

    return elements;
  }

  @override
  Widget build(BuildContext context) {
    _fileProvider = Provider.of<FileProvider>(context, listen: true);

    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Stack(
        children: _generateElements(),
      ),
    );
  }
}

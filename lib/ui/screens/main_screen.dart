import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/model/ui_file.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/ui/components/file_explorer.dart';
import 'package:flutter_finder/ui/components/previews/file_preview.dart';
import 'package:flutter_finder/ui/components/side_bar.dart';
import 'package:flutter_finder/utils/file_manager.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  FileProvider _fileProvider;

  didChangeDependencies() {
    super.didChangeDependencies();

    if (_fileProvider == null) {
      _fileProvider = Provider.of<FileProvider>(context);
      _loadDefaultFolder();
    }
  }

  _loadDefaultFolder() async {
    _fileProvider.updatePath(context, await FileManager().getHomePath());
  }

  @override
  Widget build(BuildContext context) {
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

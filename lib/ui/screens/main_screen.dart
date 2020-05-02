import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_finder/ui/components/file_explorer.dart';
import 'package:flutter_finder/ui/components/side_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _path = '/Users/lazyos';
  List<FileSystemEntity> _files = List();

  @override
  void initState() {
    _listFiles();
    super.initState();
  }

  _listFiles() async {
    Directory dir = Directory(_path);
    _files = dir.listSync();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: FileExplorer(
              fileEntities: _files,
            ),
          ),
        ],
      ),
    );
  }
}

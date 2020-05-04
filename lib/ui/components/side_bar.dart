import 'package:flutter/material.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/utils/file_manager.dart';
import 'package:provider/provider.dart';

const SIDE_BAR_SPACE = 200.0;

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  FileProvider _fileProvider;

  @override
  Widget build(BuildContext context) {
    int _index = -1;
    _fileProvider = Provider.of<FileProvider>(context);

    return Theme(
      data: ThemeData.dark(),
      child: Container(
        width: SIDE_BAR_SPACE,
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.apps),
                title: Text('Applications'),
                onTap: () async {
                  _fileProvider.updatePath(
                    context,
                    await FileManager().getApplicationPath(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.desktop_mac),
                title: Text('Desktop'),
                onTap: () async {
                  _fileProvider.updatePath(
                    context,
                    await FileManager().getDesktopPath(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.collections_bookmark),
                title: Text('Documents'),
                onTap: () async {
                  _fileProvider.updatePath(
                    context,
                    await FileManager().getDocumentPath(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Download'),
                onTap: () async {
                  _fileProvider.updatePath(
                    context,
                    await FileManager().getDownloadPath(),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () async {
                  _fileProvider.updatePath(
                    context,
                    await FileManager().getHomePath(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

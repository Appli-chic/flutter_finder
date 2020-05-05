import 'package:flutter/material.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/ui/components/side_bar_item.dart';
import 'package:flutter_finder/utils/file_manager.dart';
import 'package:provider/provider.dart';

const SIDE_BAR_SPACE = 180.0;

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  FileProvider _fileProvider;
  var _sideBarItems = List<SideBarItem>();

  didChangeDependencies() {
    super.didChangeDependencies();

    if (_fileProvider == null) {
      _fileProvider = Provider.of<FileProvider>(context);
      _loadSideBarItems();
    }
  }

  _loadSideBarItems() async {
    var futures = List<Future<String>>();

    futures.add(FileManager().getApplicationPath());
    futures.add(FileManager().getDesktopPath());
    futures.add(FileManager().getDocumentPath());
    futures.add(FileManager().getDownloadPath());
    futures.add(FileManager().getHomePath());

    var paths = await Future.wait(futures);

    // Application folder
    _sideBarItems.add(
      SideBarItem(
        title: "Applications",
        iconPath: "assets/sidebar_application.png",
        path: paths[0],
      ),
    );

    // Desktop folder
    _sideBarItems.add(
      SideBarItem(
        title: "Desktop",
        iconPath: "assets/sidebar_desktop.png",
        path: paths[1],
      ),
    );

    // Documents folder
    _sideBarItems.add(
      SideBarItem(
        title: "Documents",
        iconPath: "assets/sidebar_documents.png",
        path: paths[2],
      ),
    );

    // Download folder
    _sideBarItems.add(
      SideBarItem(
        title: "Download",
        iconPath: "assets/sidebar_download.png",
        path: paths[3],
      ),
    );

    // Home folder
    _sideBarItems.add(
      SideBarItem(
        title: "Home",
        iconPath: "assets/sidebar_home.png",
        path: paths[4],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SIDE_BAR_SPACE,
      height: MediaQuery.of(context).size.height,
      color: Color(0xFFF8F1F6),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: _sideBarItems,
        ),
      ),
    );
  }
}

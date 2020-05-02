import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        width: 200,
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.apps),
                title: Text('Applications'),
              ),
              ListTile(
                leading: Icon(Icons.desktop_mac),
                title: Text('Desktop'),
              ),
              ListTile(
                leading: Icon(Icons.collections_bookmark),
                title: Text('Documents'),
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title: Text('Download'),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_finder/providers/file_provider.dart';
import 'package:flutter_finder/ui/components/side_bar.dart';
import 'package:provider/provider.dart';

class SideBarItem extends StatefulWidget {
  SideBarItem({
    @required this.iconPath,
    @required this.title,
    @required this.path,
  });

  final String iconPath;
  final String title;
  final String path;

  @override
  _SideBarItemState createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  FileProvider _fileProvider;

  Widget _displaysIcon(String iconPath) {
    var size = 20.0;

    return Container(
      width: size,
      height: size,
      child: Image.asset(
        iconPath,
        color: Color(0xFF29263D),
      ),
    );
  }

  Widget _displaysTitle(String title) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF29263D),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fileProvider = Provider.of<FileProvider>(context);

    return GestureDetector(
      onTap: () {
        _fileProvider.updatePath(
          context,
          widget.path,
        );
      },
      child: Container(
        width: SIDE_BAR_SPACE,
        padding: EdgeInsets.only(left: 8, right: 16, top: 6, bottom: 6),
        margin: EdgeInsets.only(left: 16, top: 4),
        decoration: BoxDecoration(
          color: _fileProvider.path == widget.path ? Color(0xFFE3DCDC) : null,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4),
            topLeft: Radius.circular(4),
          ),
        ),
        child: Row(
          children: [
            _displaysIcon(widget.iconPath),
            _displaysTitle(widget.title),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FilePreview extends StatefulWidget {
  FilePreview({
    @required this.name,
    @required this.icon,
    @required this.x,
    @required this.y,
  });

  final String name;
  final IconData icon;
  final double x;
  final double y;

  @override
  _FilePreviewState createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.x,
      top: widget.y,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              widget.icon,
              color: Colors.indigo,
              size: 50,
            ),
          ),
          Container(
            width: 100,
            child: Text(
              widget.name,
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
    );
  }
}

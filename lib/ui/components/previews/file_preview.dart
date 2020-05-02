import 'package:flutter/material.dart';

class FilePreview extends StatefulWidget {
  FilePreview({
    @required this.name,
    @required this.icon,
  });

  final String name;
  final IconData icon;

  @override
  _FilePreviewState createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Icon(
            widget.icon,
            color: Colors.indigo,
            size: 50,
          ),
        ),
        Container(
          child: Text(
            widget.name,
            style: TextStyle(
              color: Colors.indigo,
              fontSize: 16
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

class UIFile {
  UIFile({
    this.fileSystemEntity,
    this.isSelected,
    this.x,
    this.y,
    this.iconPath,
    this.isFolder,
  });

  FileSystemEntity fileSystemEntity;
  bool isSelected;
  double x;
  double y;
  String iconPath;
  bool isFolder;
}

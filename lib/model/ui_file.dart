import 'dart:io';

class UIFile {
  UIFile({
    this.fileSystemEntity,
    this.isSelected,
    this.x,
    this.y,
  });

  FileSystemEntity fileSystemEntity;
  bool isSelected;
  double x;
  double y;
}

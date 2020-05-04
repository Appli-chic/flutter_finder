import 'package:flutter/services.dart';

const MethodChannel _platform = MethodChannel('plugins.applichic/file_manager');

class FileManager {
  Future<String> getHomePath() async {
    return await _platform.invokeMethod('getHomePath');
  }

  Future<String> getDownloadPath() async {
    return await _platform.invokeMethod('getDownloadPath');
  }

  Future<String> getDocumentPath() async {
    return await _platform.invokeMethod('getDocumentPath');
  }

  Future<String> getDesktopPath() async {
    return await _platform.invokeMethod('getDesktopPath');
  }

  Future<String> getApplicationPath() async {
    return "/Applications";
  }
}

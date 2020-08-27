class ModeAppRun {
  static String apiUrl = 'http://192.168.1.4:8080';
  static String mode = 'release';
  void checkedDebugMode() {
    assert(() {
      apiUrl = 'http://localhost:8080';
      mode = 'debug';
    }());
  }
}

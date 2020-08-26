class ModeAppRun {
  static String apiUrl = 'https://';
  static String mode = 'release';
  void checkedDebugMode() {
    assert(() {
      apiUrl = 'http://localhost:8080';
      mode = 'debug';
    }());
  }
}

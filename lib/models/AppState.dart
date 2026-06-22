class AppState {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal(); // Private constructor

  String langKey = "en";
}
class AppConfig {
  static AppConfig? _instance;
  String langKey = "en";

  // Private constructor
  AppConfig._();

  // Factory constructor
  factory AppConfig() {
    _instance ??= AppConfig._();
    return _instance!;
  }
}
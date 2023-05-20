abstract class Config {
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  static const String origin = String.fromEnvironment('ORIGIN');

  static const String token = String.fromEnvironment('TOKEN');
}

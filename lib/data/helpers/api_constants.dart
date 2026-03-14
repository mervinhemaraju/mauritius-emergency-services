/// Single source of truth for all API configuration.
/// Update [baseUrl] here to switch environments across the entire app.
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = "https://staging-mesapi.plagueworks.org";
  static const String version = "v1";

  static String versioned(String lang, String path) =>
      "$baseUrl/$version/$lang/$path";
}

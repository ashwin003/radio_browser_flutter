/// Browsers can neither run `ping` nor use `dart:io` DNS lookups, so on web
/// the client uses a fixed Radio Browser API server.
///
/// The trailing slash matters: Dio joins `baseUrl` and the request path by
/// plain string concatenation.
Future<String> fetchBaseUrl() async => 'https://de1.api.radio-browser.info/';

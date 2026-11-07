## 0.0.1

* Initial release.

## 0.0.2

* Minor updates

## 0.0.3

* Minor fixes

## 0.1.0

* **Breaking:** Requires Dart `>=3.10.0` and Flutter `>=3.38.0`
* Upgrades dependencies to their latest versions:
  * `dart_ping` ^10.0.1 (was ^8.0.1)
  * `dns_client` ^1.3.1 (was ^0.2.1)
  * `dio` ^5.11.1, `equatable` ^2.1.0, `json_annotation` ^4.12.0
  * Dev: `flutter_lints` ^6.0.0, `http_mock_adapter` ^0.6.1, `json_serializable` ^6.15.2, `build_runner` ^2.16.2, `mockito` ^5.8.1
* Fixes a crash when selecting the fastest API server if a ping returned an error; unreachable servers are now skipped
* Fixes the API base URL: it was a bare IP with no scheme or trailing slash, so request URLs were malformed. The fastest server's IP is now reverse-resolved to its hostname (matching its TLS certificate) and used as `https://<host>/`
* Web: uses a fixed API server instead of DNS lookup + ping (neither works in browsers); `dart_ping` is no longer compiled into web builds
* Fixes comma-separated fields (`tags`, `language`, `languageCodes`) on `Station` and `StationCheck` returning `[""]` instead of an empty list when the API sends an empty string
* Fixes incorrect expectations in station service tests

## 0.1.1

* Fixes a crash for sorting by quality
## 0.1.2

* Removes the `dart_ping` and `dns_client` dependencies. The API servers are now resolved with the system DNS resolver, and the fastest is chosen by timing a TCP connection to port 443 on every server in parallel, instead of pinging them one at a time. This starts up faster, works where ICMP is blocked or sandboxed, and fixes a dependency conflict with packages that require `code_assets` ^2.0.0 (for example `flutter_soloud` 5)
* Upgrades `equatable` to ^3.0.0. Response models are unaffected in normal use, but note the upstream changes: `toString()` no longer lists the model's fields, and equality no longer compares `runtimeType`

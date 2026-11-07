import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:dns_client/dns_client.dart';

const _unreachable = 0x7fffffffffffffff;
const _fallbackHost = 'de1.api.radio-browser.info';

/// Resolves all Radio Browser API servers via DNS-over-HTTPS, picks the one
/// with the lowest ping round-trip time and returns its base URL.
///
/// The IP is reverse-resolved to its hostname, because the servers' TLS
/// certificates are issued for hostnames, not IP addresses. The trailing slash
/// matters: Dio joins `baseUrl` and the request path by plain concatenation.
Future<String> fetchBaseUrl() async {
  final host = await _fastestHost();
  return 'https://$host/';
}

Future<String> _fastestHost() async {
  final dns = DnsOverHttps.google();
  InternetAddress? fastest;
  try {
    final ipAddresses = await dns.lookup('all.api.radio-browser.info');
    var lastRoundTripTime = _unreachable;

    /// Loop through the ipAddresses to find the fastest one
    for (final ipAddress in ipAddresses) {
      final ping = Ping(ipAddress.address, count: 1);
      final event = await ping.stream.first;
      final timeTaken = _getResponseTime(event);
      if (timeTaken < lastRoundTripTime) {
        lastRoundTripTime = timeTaken;
        fastest = ipAddress;
      }
    }
  } catch (_) {
    return _fallbackHost;
  } finally {
    dns.close(force: true);
  }

  if (fastest == null) return _fallbackHost;
  try {
    final reversed = await fastest.reverse();
    final host = reversed.host;
    // reverse() returns the IP itself when no PTR record exists.
    return host == fastest.address ? _fallbackHost : host;
  } catch (_) {
    return _fallbackHost;
  }
}

int _getResponseTime(PingEvent event) => switch (event) {
      PingResponse(:final time?) => time.inMicroseconds,
      PingSummary(:final time?) => time.inMicroseconds,
      _ => _unreachable,
    };

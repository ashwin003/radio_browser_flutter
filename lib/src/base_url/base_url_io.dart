import 'dart:async';
import 'dart:io';

const _fallbackHost = 'de1.api.radio-browser.info';
const _probeTimeout = Duration(seconds: 3);

/// Resolves all Radio Browser API servers via the system resolver, picks the one
/// that accepts a TCP connection fastest and returns its base URL.
///
/// A TCP connect to port 443 is used as the latency probe rather than an
/// ICMP ping: it needs no extra dependency or process, works where ICMP is
/// blocked or sandboxed, and measures the port the API is actually served on.
/// All servers are probed in parallel and the first to answer wins.
///
/// The IP is reverse-resolved to its hostname, because the servers' TLS
/// certificates are issued for hostnames, not IP addresses. The trailing slash
/// matters: Dio joins `baseUrl` and the request path by plain concatenation.
Future<String> fetchBaseUrl() async {
  final host = await _fastestHost();
  return 'https://$host/';
}

Future<String> _fastestHost() async {
  InternetAddress? fastest;
  try {
    final ipAddresses = await InternetAddress.lookup(
      'all.api.radio-browser.info',
    ).timeout(_probeTimeout);
    fastest = await _firstToConnect(ipAddresses);
  } catch (_) {
    return _fallbackHost;
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

/// Connects to every address at once and returns the first that accepts,
/// or null if none do within [_probeTimeout].
Future<InternetAddress?> _firstToConnect(List<InternetAddress> addresses) {
  if (addresses.isEmpty) return Future.value(null);
  final winner = Completer<InternetAddress?>();
  var pending = addresses.length;
  for (final address in addresses) {
    Socket.connect(address, 443, timeout: _probeTimeout).then(
      (socket) {
        socket.destroy();
        if (!winner.isCompleted) winner.complete(address);
      },
      onError: (_) {
        if (--pending == 0 && !winner.isCompleted) winner.complete(null);
      },
    );
  }
  return winner.future;
}

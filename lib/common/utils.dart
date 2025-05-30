import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

Future<http.Client> createHttpClientWithSslPinning() async {
  final sslCert = await rootBundle.load('certificates/themoviedb.pem');

  final context = SecurityContext(withTrustedRoots: false);
  context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

  final httpClient = HttpClient(context: context);

  // handle error
  httpClient.badCertificateCallback =
      (X509Certificate cert, String host, int port) {
    log('BAD CERT: $host');
    return false;
  };

  return IOClient(httpClient);
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

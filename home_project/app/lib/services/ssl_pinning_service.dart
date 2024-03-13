import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as io_client;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class SSLPinningService {
  Future<http.Client> createIOClient() async {
    final context = SecurityContext(withTrustedRoots: false);
    final List<int> certBytes = (await rootBundle.load('assets/certificates/my_cert.pem')).buffer.asUint8List();
    context.setTrustedCertificatesBytes(certBytes);

    HttpClient httpClient = HttpClient(context: context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Implement logic to check if the certificate is valid according to your requirements.
        // For example, you can compare the certificate's SHA256 fingerprint or subject with expected values.
        // Return true to accept the certificate, or false to reject it.
        return false; // Example: Return false by default for maximum security
      };

    return io_client.IOClient(httpClient); // Wrap the HttpClient in an IOClient from the http package
  }
}
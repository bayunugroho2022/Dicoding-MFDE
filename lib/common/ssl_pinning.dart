import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class SslPinning extends IOClient {
  Future<http.Client> get _instance async => _clientInstance ??= await createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static _log(String message) => kReleaseMode ? null : print(message);

  Future<void> init() async {
    _clientInstance = await _instance;
  }

  String _certificatedString =   rootBundle.load('certificates/certificate.cer').toString();

  Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client = IOClient(await customHttpClient(isTestMode: isTestMode));
    return client;
  }

  Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    final context = SecurityContext(
      withTrustedRoots: false,
    );
    try {
      List<int> certFileBytes = [];

      if (isTestMode) {
        _log('isTestMode is true');
        certFileBytes = utf8.encode(_certificatedString);
      } else {
        try {
          certFileBytes =
              (await rootBundle.load('certificates/certificate.cer'))
                  .buffer
                  .asInt8List();
          _log('Successfully access and load certificate.cer file!');
        } catch (e) {
          certFileBytes = utf8.encode(_certificatedString);
          _log('Error access and load certificate.cer file.\n${e.toString()}');
        }
      }

      context.setTrustedCertificatesBytes(certFileBytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        _log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        _log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      _log('unexpected error $e');
      rethrow;
    }

    final httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

}

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart';

class GetServiceKey {
  Future<String> getServiceKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": dotenv.env['GOOGLE_PROJECT_ID'] ?? '',
          "private_key_id": dotenv.env['GOOGLE_PRIVATE_KEY_ID'] ?? '',
          "private_key": dotenv.env['GOOGLE_PRIVATE_KEY'] ?? '',
          "client_email": dotenv.env['GOOGLE_CLIENT_EMAIL'] ?? '',
          "client_id": dotenv.env['GOOGLE_CLIENT_ID'],
          "auth_uri": dotenv.env['GOOGLE_AUTH_URI'],
          "token_uri": dotenv.env['q'],
          "auth_provider_x509_cert_url":
              dotenv.env['GOOGLE_AUTH_PROVIDER_CERT_URL'],
          "client_x509_cert_url": dotenv.env['GOOGLE_CLIENT_CERT_URL'],
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServiceKey = client.credentials.accessToken.data;
    if (kDebugMode) {
      print('token server : $accessServiceKey');
    }
    return accessServiceKey;
  }
}

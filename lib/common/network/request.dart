import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum RequestType { post, get, delete, put }

class RequestHabito {
  final bool _debugLogging = true;

  final String _serverUrl = "127.0.0.1:3000";
  late String _url;
  bool _badRequest = false;
  int _status = 200;
  final _client = http.Client();

  bool get isBadRequest => _badRequest;
  int get status => _status;

  RequestHabito({required url}) {
    _url = url;
  }

  Future<Map<dynamic, dynamic>> makeRequest({
    required RequestType requestType,
    Object? body,
  }) async {
    try {
      Uri uri =
          kDebugMode ? Uri.http(_serverUrl, _url) : Uri.https(_serverUrl, _url);

      final response = switch (requestType) {
        RequestType.post => await _client.post(uri, body: body),
        RequestType.get => await _client.get(uri),
        RequestType.put => await _client.put(uri, body: body),
        RequestType.delete => await _client.delete(uri, body: body),
        // _ => throw UnimplementedError()
      };

      final decodedResponse = _decodeResponse(response);

      if (_debugLogging) {
        if (kDebugMode) {
          print(decodedResponse);
        }
      }

      _status = response.statusCode;
      _badRequest = _status >= 400;

      return decodedResponse;
    } catch (err) {
      rethrow;
    } finally {
      _client.close();
    }
  }

  Map<dynamic, dynamic> _decodeResponse(http.Response response) {
    return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  }
}

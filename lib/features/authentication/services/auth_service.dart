import 'package:habito/features/authentication/models/backend_response.dart';
import 'package:habito/features/authentication/models/user_model.dart';
import 'package:habito/common/network/request.dart';

Future<HabitoResponse<User>> loginNetwork(String user, String password) async {
  var client = RequestHabito(url: '/authentication/login');
  var decodedResponse = await client.makeRequest(
    requestType: RequestType.post,
    body: {'email': user, 'password': password},
  );

  dynamic data = decodedResponse['data'];

  User? userObject = client.isBadRequest
      ? null
      : User(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          jwToken: decodedResponse['secret'],
        );

  return HabitoResponse<User>(
    data: userObject,
    statusCode: decodedResponse['statusCode'],
    error: decodedResponse['error'],
    message: decodedResponse['message'],
  );
}

Future<HabitoResponse<User>> signup({
  required String user,
  required String password,
  required String name,
}) async {
  var client = RequestHabito(url: '/authentication/new');
  var decodedResponse = await client.makeRequest(
    requestType: RequestType.post,
    body: {'email': user, 'password': password, 'name': name},
  );

  dynamic data = decodedResponse['data'];

  User? userObject = client.isBadRequest
      ? null
      : User(
          id: data['id'],
          name: data['name'],
          email: data['email'],
          jwToken: decodedResponse['secret'],
        );

  return HabitoResponse<User>(
    data: userObject,
    statusCode: decodedResponse['statusCode'],
    error: decodedResponse['error'],
    message: decodedResponse['message'],
  );
}

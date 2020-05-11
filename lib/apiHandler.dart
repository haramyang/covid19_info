import 'package:http/http.dart' as http;

class API {
  static const String _baseURL = 'https://api.thevirustracker.com/free-api?';

  static getData(String url) async {
    final response = await http.get(_baseURL + url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}
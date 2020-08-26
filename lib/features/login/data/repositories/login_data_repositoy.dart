import 'package:busmart/features/login/data/datasources/api_login.dart';
import 'package:http/http.dart' as http;

class LoginDataRepository {
  //Todo: implement the model.
  Future postLogin() async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(apiLogin, body: {});
      print('Response status: ${uriResponse.statusCode}');
      print('Response body: ${uriResponse.body}');
    } catch (e) {
      print(e.toString());
    } finally {
      client.close();
    }
  }
}

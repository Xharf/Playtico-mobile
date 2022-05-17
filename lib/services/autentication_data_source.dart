import 'base_network.dart';
class AuthenticationDataSource {
  static AuthenticationDataSource instance = AuthenticationDataSource();

  Future<Map<String, dynamic>> register(username, password, fullname) {
    return BaseNetwork.postRegister("users",username, password, fullname);
  }

  Future<Map<String, dynamic>> login(username, password) {
    return BaseNetwork.postLogin("authentications", username, password);
  }

  Future<Map<String, dynamic>> refresh(token) {
    return BaseNetwork.putAuthentication("authentications", token);
  }

}
import 'base_network.dart';
class UserDataSource {
  static UserDataSource instance = UserDataSource();

  Future<Map<String, dynamic>> get(username) {
    return BaseNetwork.get("users?username=$username");
  }
}
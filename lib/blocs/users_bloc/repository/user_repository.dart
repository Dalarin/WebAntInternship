import 'package:webant_internship/blocs/users_bloc/request/user_service.dart';
import 'package:webant_internship/models/user.dart';

class UserRepository {
  final _service = UserService();

  Future<User?> getUserById(String userId) async {
    final response = await _service.getUserById(userId);
    if (response != null) {
      return User.fromJson(response);
    }
    return null;
  }
}

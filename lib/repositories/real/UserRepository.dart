import 'package:events/models/Attendant.dart';
import 'package:events/repositories/mock/MockUserRepository.dart';

abstract class UserRepository {
  Future<User> loggedInUser();
}

final userRepository = mockUserRepository;

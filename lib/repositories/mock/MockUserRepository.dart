import 'package:events/models/Attendant.dart';
import 'package:events/repositories/real/UserRepository.dart';
import 'package:uuid/uuid.dart';

final mockUserRepository = MockUserRepository();

class MockUserRepository extends UserRepository {
  User _loggedInUser =
      User("assets/people/taras_profile.png", "Taras Koshkin", Uuid().v4());

  @override
  Future<User> loggedInUser() {
    return Future.value(_loggedInUser);
  }

  User loggedInUserInternal() => _loggedInUser;
}

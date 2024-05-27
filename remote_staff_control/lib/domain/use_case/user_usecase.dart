import 'package:remote_staff_control/domain/repositories/i_user_repository.dart';

import '../model/user.dart';

class UserUseCase {
  final IUserRepository _userRepository;
  UserUseCase(this._userRepository);

  Future<List<User>> getUsers() async => await _userRepository.getUsers();
  Future<bool> addUser(User user) async => await _userRepository.addUser(user);
  Future<bool> updateUser(User user) async =>
      await _userRepository.updateUser(user);
  Future<bool> deleteUser(int id) async => await _userRepository.deleteUser(id);
}

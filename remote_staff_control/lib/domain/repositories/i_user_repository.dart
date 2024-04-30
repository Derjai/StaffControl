import '../model/user.dart';

abstract class IUserRepository {
  final IUserRepository _userDataSource;

  IUserRepository(this._userDataSource);

  Future<List<User>> getUsers();

  Future<bool> addUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);
}

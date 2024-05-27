import '../../../domain/model/user.dart';

abstract class IUserDatasource {
  Future<List<User>> getUsers();
  Future<bool> addUser(User user);
  Future<bool> updateUser(User user);
  Future<bool> deleteUser(int id);
}

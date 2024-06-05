import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/ui/controllers/user_controller.dart';
import 'package:remote_staff_control/domain/model/user.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';
import 'user_usecase_mock.dart';

void main() {
  late MockUserUseCase mockUserUseCase;
  late UserController userController;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
    Get.put<UserUseCase>(mockUserUseCase); // Registrar el mock en GetX
    userController = UserController();
  });

  test('initial user list should be empty', () {
    expect(userController.user, isEmpty);
  });

  test('getUsers should fetch users from use case', () async {
    final userList = [
      User(
          id: 1,
          name: 'User 1',
          email: 'user1@example.com',
          password: 'password1')
    ];
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => userList);

    await userController.getUsers();

    expect(userController.user, userList);
    verify(mockUserUseCase.getUsers()).called(1);
  });

  test('addUser should call use case and refresh user list', () async {
    final user = User(
        id: 2,
        name: 'User 2',
        email: 'user2@example.com',
        password: 'password2');
    final userList = [user];
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => userList);

    await userController.addUser(user);

    verify(mockUserUseCase.addUser(user)).called(1);
    verify(mockUserUseCase.getUsers()).called(1);
    expect(userController.user, userList);
  });

  test('updateUser should call use case and refresh user list', () async {
    final user = User(
        id: 1,
        name: 'Updated User',
        email: 'updated@example.com',
        password: 'updatedPassword');
    final userList = [user];
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => userList);

    await userController.updateUser(user);

    verify(mockUserUseCase.updateUser(user)).called(1);
    verify(mockUserUseCase.getUsers()).called(1);
    expect(userController.user, userList);
  });

  test('deleteUser should call use case and refresh user list', () async {
    final userId = 1;
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => []);

    await userController.deleteUser(userId);

    verify(mockUserUseCase.deleteUser(userId)).called(1);
    verify(mockUserUseCase.getUsers()).called(1);
    expect(userController.user, isEmpty);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/ui/controllers/user_controller.dart';
import 'package:remote_staff_control/domain/model/user.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';
import '../unit_test/mocks/user_controller_test.mocks.dart';

@GenerateMocks([UserUseCase])
void main() {
  late MockUserUseCase mockUserUseCase;
  late UserController userController;

  setUp(() {
    mockUserUseCase = MockUserUseCase();
    Get.put<UserUseCase>(mockUserUseCase);
    userController = UserController();
  });

  tearDown(() {
    Get.reset();
  });

  test('getUsers should fetch users from use case', () async {
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => [
          User(
              id: 1,
              name: 'User 1',
              email: 'user1@example.com',
              password: '000')
        ]);

    await userController.getUsers();
    verify(mockUserUseCase.getUsers()).called(1);
  });

  test('addUser should call use case and refresh user list', () async {
    final user = User(
        id: 1, name: 'User 1', email: 'user1@example.com', password: '000');
    when(mockUserUseCase.addUser(user)).thenAnswer((_) async => true);
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => [user]);

    await userController.addUser(user);

    verify(mockUserUseCase.addUser(user)).called(1);
    verify(mockUserUseCase.getUsers()).called(1);
  });

  test('updateUser should call use case and refresh user list', () async {
    final user = User(
        id: 1, name: 'User 1', email: 'user1@example.com', password: '000');

    final updatedUser = User(
        id: 1, name: 'User 1', email: 'updated@example.com', password: '000');
    when(mockUserUseCase.addUser(user)).thenAnswer((_) async => true);
    when(mockUserUseCase.updateUser(user)).thenAnswer((_) async => true);
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => [updatedUser]);

    await userController.addUser(user);
    await userController.updateUser(user);

    verify(mockUserUseCase.updateUser(user)).called(1);
    verify(mockUserUseCase.getUsers()).called(2);
    expect(userController.user, isNotEmpty);
    expect(userController.user.first.email, 'updated@example.com');
  });

  test('deleteUser should call use case and refresh user list', () async {
    final user = User(
        id: 1, name: 'User 1', email: 'user1@example.com', password: '000');
    when(mockUserUseCase.addUser(user)).thenAnswer((_) async => true);
    when(mockUserUseCase.deleteUser(user.id!)).thenAnswer((_) async => true);
    when(mockUserUseCase.getUsers()).thenAnswer((_) async => []);

    await userController.addUser(user);
    await userController.deleteUser(user.id!);

    verify(mockUserUseCase.deleteUser(user.id!)).called(1);
    verify(mockUserUseCase.getUsers()).called(2);
    expect(userController.user, isEmpty);
  });
}

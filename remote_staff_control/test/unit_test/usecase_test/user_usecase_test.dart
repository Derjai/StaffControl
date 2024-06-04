import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_staff_control/domain/model/user.dart';
import 'package:remote_staff_control/domain/repositories/i_user_repository.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';
import '../mocks/user_usecase_test.mocks.dart';

@GenerateMocks([IUserRepository])
void main() {
  var mockUserRepository = MockIUserRepository();
  late UserUseCase userUseCase;
  late User newUser;

  setUp(() {
    userUseCase = UserUseCase(mockUserRepository);
    newUser = User(
        id: 1000,
        name: 'Test User',
        email: 'example@gmail.com',
        password: '000');
    when(mockUserRepository.addUser(any)).thenAnswer((_) async => true);
    when(mockUserRepository.updateUser(any)).thenAnswer((_) async => true);
    when(mockUserRepository.deleteUser(any)).thenAnswer((_) async => true);
  });

  test('addUser adds a user', () async {
    bool result = await userUseCase.addUser(newUser);
    expect(result, true);
    verify(mockUserRepository.addUser(newUser));
  });

  test('updateUser updates a user', () async {
    bool result = await userUseCase.updateUser(newUser);
    expect(result, true);
    verify(mockUserRepository.updateUser(newUser));
  });

  test('deleteUser deletes a user', () async {
    bool result = await userUseCase.deleteUser(newUser.id!);
    expect(result, true);
    verify(mockUserRepository.deleteUser(newUser.id!));
  });
}

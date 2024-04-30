import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:remote_staff_control/domain/use_case/user_usecase.dart';

import '../../domain/model/user.dart';

class UserController extends GetxController {
  final _user = <User>[].obs;
  final UserUseCase _userUseCase = Get.find();

  List<User> get user => _user;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  getUsers() async {
    logInfo("Getting users");
    _user.value = await _userUseCase.getUsers();
  }

  addUser(User user) async {
    logInfo("Adding user");
    await _userUseCase.addUser(user);
    getUsers();
  }

  updateUser(User user) async {
    logInfo("Updating user");
    await _userUseCase.updateUser(user);
    getUsers();
  }

  deleteUser(int id) async {
    logInfo("Deleting user");
    await _userUseCase.deleteUser(id);
    getUsers();
  }
}

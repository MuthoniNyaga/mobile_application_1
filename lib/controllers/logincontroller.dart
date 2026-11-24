import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Logincontroller extends GetxController {
  final username = ''.obs;
  final email = ''.obs;
  final GetStorage store = GetStorage();

  @override
  void onInit() {
    super.onInit();
    username.value = readusername();
    email.value = reademail();
  }

  Future<void> saveuser(String username, String email) async {
    this.username.value = username;
    this.email.value = email;
    await store.write('username', username);
    await store.write('email', email);
  }

  Future<void> clearuser() async {
    username.value = '';
    email.value = '';
    await store.remove('username');
    await store.remove('email');
  }

  String readusername() => store.read('username') ?? '';

  String reademail() => store.read('email') ?? '';
}

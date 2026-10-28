import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Logincontroller extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  void login() async {
    isLoading.value = true;
    try {
      // Simulate a login process
      await Future.delayed(Duration(seconds: 2));
      // Here you would typically call your authentication service
      // For example: await AuthService.login(email.value, password.value);
      Get.snackbar('Success', 'Logged in successfully');
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
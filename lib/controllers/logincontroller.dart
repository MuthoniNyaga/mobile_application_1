import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class Logincontroller extends GetxController {
 var username = ''.obs;
  final  store=GetStorage();
  void saveusername(String username){
  this .username.value = username;
    store.write("username", username);
  }
  String readusername()=>store.read("username")?? "";
  }
  
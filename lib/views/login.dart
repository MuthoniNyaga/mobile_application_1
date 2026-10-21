import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daystar Application"),
        backgroundColor:primaryColor, 
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("Du.jpg", height: 100, width: 200)],
            ),
            SizedBox(height: 25),
            Text(
              "Enter your username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: primaryColor, 
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: "Enter your username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Enter your password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: primaryColor, 
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Your secret code",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
              ),
            ),
            SizedBox(height: 25),
            MaterialButton(
              onPressed: () {
                if (usernameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please enter username and password",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                } else {
                  Get.offAndToNamed("/home");
                  Get.snackbar(
                    "Login Successful",
                    "The username is ${usernameController.text} and the password is ${passwordController.text}",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: primaryColor,
                    colorText: Colors.white,
                  );

                }

                Get.snackbar(
                  "Login Successful",
                  "The username is ${usernameController.text} and the password is ${passwordController.text}",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: primaryColor,
                  colorText: Colors.white,
                );
              },
              color: primaryColor,
              height: 50,
              minWidth: double.infinity,
              child: const Text("login"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("No Account?"),
                SizedBox(width: 5),
                GestureDetector(
                  child: Text(
                    "Signup",
                    style: TextStyle(fontSize: 16, color: primaryColor),
                  ),onTap:(){
                    Get.toNamed("/signup");
                  }
                ),
                Spacer(),
                Text("Forgot password?"),
                SizedBox(width: 5),
                Text(
                  "Recover",
                  style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

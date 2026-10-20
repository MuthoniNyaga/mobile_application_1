import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController emailController = TextEditingController();

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daystar Application"),
        backgroundColor: const Color.fromARGB(255, 68, 138, 255),
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
            // Add your sign-up form fields here
            SizedBox(height: 15),
            const Text(
              "Enter your username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.blueAccent,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter your username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              controller: usernameController,
            ),
            SizedBox(height: 15),
            const Text(
              "Enter your email",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.blueAccent,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              controller: emailController,
            ),
            SizedBox(height: 15),
            const Text(
              "Enter your password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.blueAccent,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "Enter your password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              controller: passwordController,
            ),
            SizedBox(height: 15),
            MaterialButton(
              onPressed: () {
                if (usernameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Please fill in all fields",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.redAccent,
                    colorText: Colors.white,
                  );
                  return;
                }else {
                  Get.snackbar(
                    "Sign Up Successful",
                    "The username is ${usernameController.text}, the email is ${emailController.text}, and the password is ${passwordController.text}",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueAccent,
                    colorText: Colors.white,
                  );
                }
                // Handle sign-up logic here
              },
              color: Colors.blueAccent,
              minWidth: double.infinity,
              height: 50,
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Get.back(); // Navigate back to the login screen
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

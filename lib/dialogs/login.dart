import 'package:flutter/material.dart';

class LoginDialog {
  static void showLoginDialog(
      BuildContext context, {
        required String message,
        required bool isSuccess,
      }) async {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    bool isDesktop = MediaQuery.of(context).size.width >= 1024.0;
    Size size = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: isSuccess ? Colors.green[50] : Colors.red[50],
          child: Container(
            height: isDesktop ? size.height * 0.4 : size.height * 0.5,
            width: isDesktop ? size.width * 0.18 : size.width * 0.3,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0), // Spacing between fields
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  isSuccess ? "SUCCESS!" : "ERROR!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: isSuccess ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: Colors.yellow,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      side: BorderSide.none,
                    ),
                  ),
                  onPressed: () {
                    // Handle login logic here
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    // You can perform your login logic here
                    print('Username: $username');
                    print('Password: $password');

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:convert';
import 'package:advance_datase/dashboard/user_dashboard.dart';
import 'package:advance_datase/register/register.dart';
import 'package:advance_datase/session_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Login"),
          SizedBox(height: 20),
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: "Username",
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              login();
            },
            child: Text("Login"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              );
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }

  void login() async {
    try {
      var url = Uri.parse("${SessionStorage.url}login.php");
      Map<String, dynamic> jsonData = {
        "username": _usernameController.text,
        "password": _passwordController.text,
      };

      Map<String, String> requestBody = {
        "operation": "login",
        "json": jsonEncode(jsonData)
      };
      print(url);

      var response = await http.post(url, body: requestBody);
      var res = json.decode(response.body);

      if (res != 0) {
        // Navigate to the UserDashboard if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserDashboard()),
        );
        print("Successful Login");
      } else {
        print("Login failed: Incorrect username or password");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }
}

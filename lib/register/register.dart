import 'dart:convert';

import 'package:advance_datase/login/login.dart';
import 'package:advance_datase/session_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  void register() async {
    try {
      Map<String, dynamic> jsonData = {
        "username": _usernameController.text,
        "password": _passwordController.text,
        "fname": _firstnameController.text,
        "lname": _lastnameController.text
      };
      Map<String, String> requestBody = {
        "operation": "register",
        "json": jsonEncode(jsonData)
      };
      var url = Uri.parse("${SessionStorage.url}login.php");
      var response = await http.post(url, body: requestBody);
      var res = json.decode(response.body);
      print(res);
      if (res != 0) {
        print("Registration successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        print("Registration failed");
      }
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Register"),
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
          TextFormField(
            controller: _firstnameController,
            decoration: InputDecoration(
              hintText: "Firstname",
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _lastnameController,
            decoration: InputDecoration(
              hintText: "Lastname",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              register();
            },
            child: Text("Register"),
          ),
        ],
      ),
    );
  }
}

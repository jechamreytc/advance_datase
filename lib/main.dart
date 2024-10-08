import 'package:advance_datase/components/get_all_data.dart';
import 'package:advance_datase/login/user_login.dart';
import 'package:advance_datase/register/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserLogin(),
    );
  }
}

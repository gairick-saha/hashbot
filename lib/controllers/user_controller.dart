import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashbot/model/user_model.dart';
import 'package:hashbot/ui/screens/home_screen.dart';

class UserController extends GetxController {
  List<User> _user = [];

  String userName = "";

  final FocusNode focusUsername = FocusNode();

  void readFormInput(field, value) {
    field = value;
    update();
  }

  void createUser() {
    if (userName.isNotEmpty) {
      _user.insert(
        0,
        User(
          username: userName,
          avatar: 'assets/images/boy.png',
        ),
      );
      _user.insert(
        0,
        User(
          username: 'Hashbot',
          avatar: 'assets/images/bot.png',
        ),
      );
      print('User Created');

      Get.offAll(() => HomeScreen());
    }
  }

  List<User> get allUser => _user;
}

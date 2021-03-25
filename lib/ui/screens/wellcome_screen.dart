import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:get/get.dart';
import 'package:hashbot/controllers/user_controller.dart';
import 'package:hashbot/ui/utils/ui_helper.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.5,
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 1.0,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Wellcome to Hashbot',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth(context) * 0.07,
                      ),
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(text: '\n'),
                    TextSpan(
                      text: 'Please Enter Your Name to Chat',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                        fontSize: screenWidth(context) * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * 0.05,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth(context) * 0.9,
                ),
                child: TextFormField(
                  onChanged: (value) {
                    userController.userName = value;
                    userController.readFormInput('email', value);
                  },
                  focusNode: userController.focusUsername,
                  obscureText: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a username';
                    } else if (value.length < 3) {
                      return 'Username must be 3 char long';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: screenWidth(context) * 0.04,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Iconic.user,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth(context) * 0.04,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffD1D1D1),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth(context) * 0.9,
                ),
                child: ProgressButton(
                  height: screenHeight(context) * 0.07,
                  type: ProgressButtonType.Raised,
                  progressWidget: CircularProgressIndicator(),
                  defaultWidget: Text(
                    'SUBMIT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await Future.delayed(Duration(milliseconds: 1500));
                      userController.createUser();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

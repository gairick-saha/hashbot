import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashbot/services/local_auth_service.dart';
import 'package:hashbot/ui/screens/wellcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalAuthApi.internal().authenticate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hashbot',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      // home: LoginScreen(),
    );
  }
}

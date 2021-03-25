import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashbot/controllers/user_controller.dart';
import 'package:hashbot/ui/screens/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Inbox'),
        ),
      ),
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) => ListView.builder(
          itemCount: controller.allUser.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 1) {
              return null;
            }
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  controller.allUser[index].avatar,
                ),
              ),
              title: Text(
                controller.allUser[index].username,
              ),
              subtitle: Text('Tap to Chat'),
              onTap: () {
                Get.to(
                  () => ChatScreen(
                    senderName: controller.allUser[index].username,
                    userAvatar: controller.allUser[index].avatar,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashbot/controllers/bot_controller.dart';
import 'package:hashbot/ui/utils/ui_helper.dart';

class MessageInputSection extends GetWidget<BotController> {
  const MessageInputSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.textEditingController,
      onTap: () {
        Timer(
            Duration(milliseconds: 300),
            () => controller.scrollController
                .jumpTo(controller.scrollController.position.maxScrollExtent));
      },
      style: TextStyle(
        fontSize: screenWidth(context) * 0.04,
        height: screenHeight(context) * 0.002,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        fillColor: Colors.black,
        focusColor: Colors.transparent,
        hintText: 'Send a message',
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          iconSize: screenWidth(context) * 0.05,
          disabledColor: Colors.grey,
          onPressed: () {
            controller.sendMessage();
          },
        ),
      ),
    );
  }
}

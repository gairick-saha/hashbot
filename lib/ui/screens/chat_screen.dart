import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:get/get.dart';
import 'package:hashbot/controllers/bot_controller.dart';
import 'package:hashbot/ui/utils/ui_helper.dart';
import 'package:hashbot/ui/widgets/chat_bubble_widget.dart';

class ChatScreen extends GetWidget<BotController> {
  final String senderName;
  final String userAvatar;

  ChatScreen({
    @required this.senderName,
    @required this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: screenWidth(context) * 0.12,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: screenWidth(context) * 0.05,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                this.userAvatar,
              ),
            ),
            SizedBox(
              width: screenWidth(context) * 0.02,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: this.senderName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth(context) * 0.04,
                    ),
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Online',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: screenWidth(context) * 0.028,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatList(
              context,
            ),
          ),
          GetBuilder<BotController>(
            init: Get.put(BotController()),
            builder: (controller) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth(context) * 0.03,
                vertical: screenHeight(context) * 0.005,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 0,
                  ),
                ],
              ),
              child: TextField(
                controller: controller.textEditingController,
                onTap: () {
                  Timer(
                      Duration(milliseconds: 300),
                      () => controller.scrollController.jumpTo(controller
                          .scrollController.position.maxScrollExtent));
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatList(BuildContext context) {
    return GetBuilder<BotController>(
      builder: (controller) {
        if (!controller.isLoading) {
          return Center(
            child: Text("Hashbot is initializing"),
          );
        } else {
          return ListView.separated(
            itemCount: controller.allMessage.length,
            reverse: false,
            shrinkWrap: false,
            controller: controller.scrollController,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.transparent,
                height: screenHeight(context) * 0.0,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              if (controller.allMessage[index].sender == controller.botUser) {
                return ChatBubbleWidget(
                  bubbleAlignment: Alignment.topLeft,
                  bubbleType: BubbleType.receiverBubble,
                  userAvatar: AssetImage(
                    controller.allMessage[index].sender.avatar,
                  ),
                  message: controller.allMessage[index].message,
                );
              } else {
                return ChatBubbleWidget(
                  bubbleAlignment: Alignment.topRight,
                  bubbleType: BubbleType.sendBubble,
                  userAvatar: AssetImage(
                    controller.allMessage[index].sender.avatar,
                  ),
                  message: controller.allMessage[index].message,
                );
              }
            },
          );
        }
      },
    );
  }
}

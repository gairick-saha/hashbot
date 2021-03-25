import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:hashbot/ui/utils/ui_helper.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Alignment bubbleAlignment;
  final String message;
  final AssetImage userAvatar;
  final BubbleType bubbleType;
  const ChatBubbleWidget({
    @required this.bubbleAlignment,
    @required this.message,
    @required this.userAvatar,
    @required this.bubbleType,
  });

  @override
  Widget build(BuildContext context) {
    if (bubbleAlignment == Alignment.topLeft) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth(context) * 0.03,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: screenHeight(context) * 0.015,
            ),
            child: CircleAvatar(
              radius: screenWidth(context) * 0.04,
              backgroundColor: Colors.transparent,
              backgroundImage: this.userAvatar,
            ),
          ),
          _messages(
              context, this.message, this.bubbleAlignment, this.bubbleType),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _messages(
              context, this.message, this.bubbleAlignment, this.bubbleType),
          Container(
            margin: EdgeInsets.only(
              bottom: screenHeight(context) * 0.015,
            ),
            child: CircleAvatar(
              radius: screenWidth(context) * 0.04,
              backgroundColor: Colors.transparent,
              backgroundImage: this.userAvatar,
            ),
          ),
          SizedBox(
            width: screenWidth(context) * 0.03,
          ),
        ],
      );
    }
  }
}

Widget _messages(BuildContext context, String message,
    Alignment bubbleAlignment, BubbleType bubbleType) {
  return ChatBubble(
    clipper: ChatBubbleClipper3(type: bubbleType),
    alignment: bubbleAlignment,
    margin: EdgeInsets.only(
      top: screenHeight(context) * 0.02,
      left: screenWidth(context) * 0.01,
      bottom: screenHeight(context) * 0.02,
    ),
    backGroundColor:
        bubbleAlignment == Alignment.topLeft ? Colors.grey : Colors.blue,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth(context) * 0.7,
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

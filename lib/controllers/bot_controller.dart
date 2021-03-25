import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashbot/controllers/user_controller.dart';
import 'package:hashbot/model/message_model.dart';
import 'package:hashbot/model/user_model.dart';
import 'package:hashbot/services/api.dart';

class BotController extends GetxController {
  final TextEditingController textEditingController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final String _initMessage = 'Hi, How can i help you today?';

  bool isLoading = false;

  String reqType = 'normal';
  final String firstReq = 'normal';
  final String secondReq = 'mobileverify';
  final String thirdReq = 'otp';
  final String fourthReq = 'acverified';

  UserController _userController = Get.find<UserController>();
  List<Message> _messages = <Message>[];

  User get botUser => _userController.allUser[0];

  User get currentUser => _userController.allUser[1];

  List<Message> get allMessage => _messages;

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(
      Duration(milliseconds: 1500),
      () {
        _messages.add(
          Message(
            sender: botUser,
            message: _initMessage,
          ),
        );

        isLoading = true;
      },
    );
    update();
  }

  Future<void> sendMessage() async {
    final message = textEditingController.text.toLowerCase();

    if (message.trim().isNotEmpty) {
      Timer(
        Duration(milliseconds: 500),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent),
      );
      _messages.add(
        Message(
          sender: currentUser,
          message: textEditingController.text,
        ),
      );

      textEditingController.clear();

      update();

      await Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
        () {
          if (message == 'Hi' ||
              message == 'hi' ||
              message == 'Hello' ||
              message == 'hello') {
            Api.internal().get().then((response) {
              final res = {
                "response": "Please " +
                    response['response'] +
                    "\n" +
                    "\n" +
                    "Available Service :" +
                    "\n" +
                    "\n" +
                    "My Account Balance"
              };
              _botReply(res);
              reqType = response['for'];
            });
          } else if (message == "my account balance" ||
              message == "account balance" ||
              message == "balance" ||
              message == "my account" ||
              message == "account") {
            Api.internal().post(reqType, message).then(
              (response) {
                _botReply(response);
                reqType = response['for'];
              },
            );
          } else if (reqType == secondReq) {
            Api.internal().post(secondReq, message).then(
              (response) {
                _botReply(response);
                reqType = response['for'];
              },
            );
          } else if (reqType == thirdReq) {
            Api.internal().post(thirdReq, message).then(
              (response) {
                if (message.length > 6) {
                  final res = {
                    "response": "Verification Failed",
                  };
                  reqType = thirdReq;
                  _botReply(res);
                } else {
                  reqType = response['for'];
                  if (reqType == null) {
                    reqType = thirdReq;
                    _botReply(response);
                  } else {
                    final res = {
                      'response': response['response'] +
                          "\n" +
                          "\n" +
                          'Please reply with following options :' +
                          "\n" +
                          "\n" +
                          response['data']
                              .toString()
                              .replaceAll('{', '')
                              .replaceAll('}', '')
                              .replaceAll(',', '\n')
                              .replaceAll(':', '')
                              .replaceAll('q1', '')
                              .replaceAll('q2', '')
                              .replaceAll('q3', '')
                              .removeAllWhitespace,
                    };
                    reqType = response['for'];
                    _botReply(res);
                  }
                }
              },
            );
          } else if (reqType == fourthReq) {
            Api.internal().post(fourthReq, message).then(
              (response) {
                final data = response["data"];

                if (data == null) {
                  final res = {
                    "response": response['response'] +
                        "\n" +
                        "\n" +
                        'Please reply with following options :' +
                        "\n" +
                        "\n" +
                        "Balance" +
                        "\n" +
                        "Last Transactions" +
                        "\n" +
                        "Campaings",
                  };
                  _botReply(res);
                } else {
                  _botReply(response);
                }
                print(response);
                reqType = fourthReq;
              },
            );
          } else {
            final res = {
              "response":
                  "I am not sure about that maybe I can help you with the following options :" +
                      "\n" +
                      "\n" +
                      "My Account Balance"
            };
            reqType = firstReq;
            _botReply(res);
          }
        },
      );
    }
  }

  _botReply(response) {
    Timer(
      Duration(milliseconds: 500),
      () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
    );

    _messages.add(
      Message(
        sender: botUser,
        message: response['response'],
      ),
    );

    update();
  }
}

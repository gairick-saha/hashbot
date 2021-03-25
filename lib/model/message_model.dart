import 'package:hashbot/model/user_model.dart';

class Message {
  int id;
  User sender;
  String message;

  Message({
    this.id,
    this.sender,
    this.message,
  });
}

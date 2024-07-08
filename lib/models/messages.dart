import 'package:chatapp/constants/constant.dart';

class Messages {
  String message;
  String id;
  String date;
  Messages(this.message, this.id, this.date);

  factory Messages.fromJson(dynamic jsonData) {
    return Messages(jsonData[kMessage], jsonData['id'], jsonData['createdAt']);
  }
}

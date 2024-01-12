
import 'dart:convert';
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  String message;
  String uid;

  UserModel({
    required this.status,
    required this.message,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    message: json["message"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "uid": uid,
  };
}

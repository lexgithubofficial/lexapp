// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  String status;
  Data data;

  UserData({
    required this.status,
    required this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  int uid;
  String profileImage;
  String fullName;
  String email;
  String phone;
  String password;
  String date;
  int role;

  Data({
    required this.uid,
    required this.profileImage,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.date,
    required this.role,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uid: json["uid"],
    profileImage: json["profile_image"],
    fullName: json["full_name"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    date: json["date"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "profile_image": profileImage,
    "full_name": fullName,
    "email": email,
    "phone": phone,
    "password": password,
    "date": date,
    "role": role,
  };
}

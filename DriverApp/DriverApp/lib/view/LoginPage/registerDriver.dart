// To parse this JSON data, do
//
//     final registerDriver = registerDriverFromJson(jsonString);

import 'dart:convert';

RegisterDriver registerDriverFromJson(String str) => RegisterDriver.fromJson(json.decode(str));

String registerDriverToJson(RegisterDriver data) => json.encode(data.toJson());

class RegisterDriver {
  String status;
  String message;
  String dId;

  RegisterDriver({
    required this.status,
    required this.message,
    required this.dId,
  });

  factory RegisterDriver.fromJson(Map<String, dynamic> json) => RegisterDriver(
    status: json["status"],
    message: json["message"],
    dId: json["d_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "d_id": dId,
  };
}

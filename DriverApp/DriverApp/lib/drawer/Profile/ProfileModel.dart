// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String status;
  Data data;

  ProfileModel({
    required this.status,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  int dId;
  String profileImage;
  String fullName;
  String email;
  String password;
  String phone;
  String jobType;
  String assigTeam;
  String date;
  String carName;
  String carNo;
  String licenceNo;
  String carModel;
  dynamic carImage;
  String latitude;
  String longitude;
  int role;
  DateTime createdAt;
  dynamic updatedAt;

  Data({
    required this.dId,
    required this.profileImage,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.jobType,
    required this.assigTeam,
    required this.date,
    required this.carName,
    required this.carNo,
    required this.licenceNo,
    required this.carModel,
    required this.carImage,
    required this.latitude,
    required this.longitude,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dId: json["d_id"],
    profileImage: json["profile_image"],
    fullName: json["full_name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    jobType: json["job_type"],
    assigTeam: json["assig_team"],
    date: json["date"],
    carName: json["car_name"],
    carNo: json["car_no"],
    licenceNo: json["licence_no"],
    carModel: json["car_model"],
    carImage: json["car_image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "d_id": dId,
    "profile_image": profileImage,
    "full_name": fullName,
    "email": email,
    "password": password,
    "phone": phone,
    "job_type": jobType,
    "assig_team": assigTeam,
    "date": date,
    "car_name": carName,
    "car_no": carNo,
    "licence_no": licenceNo,
    "car_model": carModel,
    "car_image": carImage,
    "latitude": latitude,
    "longitude": longitude,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
  };
}

// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
  String status;
  List<Datum> data;

  CarModel({
    required this.status,
    required this.data,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String uid;
  String carName;
  String carImage;
  String carId;
  String totalCustomer;
  String totalBag;
  String date;

  Datum({
    required this.id,
    required this.uid,
    required this.carName,
    required this.carImage,
    required this.carId,
    required this.totalCustomer,
    required this.totalBag,
    required this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uid: json["d_id"],
    carName: json["car_name"],
    carImage: json["car_image"],
    carId: json["car_id"],
    totalCustomer: json["total_customer"],
    totalBag: json["total_bag"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "d_id": uid,
    "car_name": carName,
    "car_image": carImage,
    "car_id": carId,
    "total_customer": totalCustomer,
    "total_bag": totalBag,
    "date": date,
  };
}

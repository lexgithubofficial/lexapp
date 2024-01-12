// To parse this JSON data, do
//
//     final aceeptedCustomer = aceeptedCustomerFromJson(jsonString);

import 'dart:convert';

AceeptedCustomer aceeptedCustomerFromJson(String str) => AceeptedCustomer.fromJson(json.decode(str));

String aceeptedCustomerToJson(AceeptedCustomer data) => json.encode(data.toJson());

class AceeptedCustomer {
  String status;
  List<Datum> data;

  AceeptedCustomer({
    required this.status,
    required this.data,
  });

  factory AceeptedCustomer.fromJson(Map<String, dynamic> json) => AceeptedCustomer(
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
  int uid;
  String picLocation;
  String dropLocation;
  String cId;
  String dId;
  String biddingPrice;
  String kmRange;
  String travelTime;
  String date;
  int status;
  String fullName;

  Datum({
    required this.id,
    required this.uid,
    required this.picLocation,
    required this.dropLocation,
    required this.cId,
    required this.dId,
    required this.biddingPrice,
    required this.kmRange,
    required this.travelTime,
    required this.date,
    required this.status,
    required this.fullName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    uid: json["uid"],
    picLocation: json["pic_location"],
    dropLocation: json["drop_location"],
    cId: json["c_id"],
    dId: json["d_id"],
    biddingPrice: json["bidding_price"],
    kmRange: json["km_range"],
    travelTime: json["travel_time"],
    date: json["date"],
    status: json["status"],
    fullName: json["full_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "pic_location": picLocation,
    "drop_location": dropLocation,
    "c_id": cId,
    "d_id": dId,
    "bidding_price": biddingPrice,
    "km_range": kmRange,
    "travel_time": travelTime,
    "date": date,
    "status": status,
    "full_name": fullName,
  };
}

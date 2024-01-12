// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

CustomerData customerDataFromJson(String str) => CustomerData.fromJson(json.decode(str));

String customerDataToJson(CustomerData data) => json.encode(data.toJson());

class CustomerData {
  String status;
  List<Datum> data;

  CustomerData({
    required this.status,
    required this.data,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
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
  int previousBookingId;
  int userId;
  String pickupLocation;
  String dropLocation;
  String distance;
  String bid;
  int dId;
  DateTime acceptedTime;
  dynamic journeyStartTime;
  dynamic journeyEndTime;
  int journeyStatus;
  dynamic paymentId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Datum({
    required this.id,
    required this.previousBookingId,
    required this.userId,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    required this.bid,
    required this.dId,
    required this.acceptedTime,
    required this.journeyStartTime,
    required this.journeyEndTime,
    required this.journeyStatus,
    required this.paymentId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    previousBookingId: json["previous_booking_id"],
    userId: json["user_id"],
    pickupLocation: json["pickup_location"],
    dropLocation: json["drop_location"],
    distance: json["distance"],
    bid: json["bid"],
    dId: json["d_id"],
    acceptedTime: DateTime.parse(json["accepted_time"]),
    journeyStartTime: json["journey_start_time"],
    journeyEndTime: json["journey_end_time"],
    journeyStatus: json["journey_status"],
    paymentId: json["payment_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "previous_booking_id": previousBookingId,
    "user_id": userId,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "distance": distance,
    "bid": bid,
    "d_id": dId,
    "accepted_time": acceptedTime.toIso8601String(),
    "journey_start_time": journeyStartTime,
    "journey_end_time": journeyEndTime,
    "journey_status": journeyStatus,
    "payment_id": paymentId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

// To parse this JSON data, do
//
//     final trackingHistory = trackingHistoryFromJson(jsonString);

import 'dart:convert';

TrackingHistory trackingHistoryFromJson(String str) => TrackingHistory.fromJson(json.decode(str));

String trackingHistoryToJson(TrackingHistory data) => json.encode(data.toJson());

class TrackingHistory {
  String? status;
  List<Datum>? data;

  TrackingHistory({
    this.status,
    this.data,
  });

  factory TrackingHistory.fromJson(Map<String, dynamic> json) => TrackingHistory(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  int? previousBookingId;
  int? userId;
  String? pickupLocation;
  String? dropLocation;
  String? distance;
  String? bid;
  int? dId;
  DateTime? acceptedTime;
  DateTime? journeyStartTime;
  DateTime? journeyEndTime;
  int? journeyStatus;
  dynamic paymentId;
  String? customerLongitude;
  String? customerLatitude;
  dynamic adminFee;
  String? adminPaymentStatus;
  int? otp;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? profileImage;

  Datum({
    this.id,
    this.previousBookingId,
    this.userId,
    this.pickupLocation,
    this.dropLocation,
    this.distance,
    this.bid,
    this.dId,
    this.acceptedTime,
    this.journeyStartTime,
    this.journeyEndTime,
    this.journeyStatus,
    this.paymentId,
    this.customerLongitude,
    this.customerLatitude,
    this.adminFee,
    this.adminPaymentStatus,
    this.otp,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.profileImage,
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
    acceptedTime: json["accepted_time"] == null ? null : DateTime.parse(json["accepted_time"]),
    journeyStartTime: json["journey_start_time"] == null ? null : DateTime.parse(json["journey_start_time"]),
    journeyEndTime: json["journey_end_time"] == null ? null : DateTime.parse(json["journey_end_time"]),
    journeyStatus: json["journey_status"],
    paymentId: json["payment_id"],
    customerLongitude: json["customer_longitude"],
    customerLatitude: json["customer_latitude"],
    adminFee: json["admin_fee"],
    adminPaymentStatus: json["admin_payment_status"],
    otp: json["otp"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    profileImage: json["profile_image"],
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
    "accepted_time": acceptedTime?.toIso8601String(),
    "journey_start_time": journeyStartTime?.toIso8601String(),
    "journey_end_time": journeyEndTime?.toIso8601String(),
    "journey_status": journeyStatus,
    "payment_id": paymentId,
    "customer_longitude": customerLongitude,
    "customer_latitude": customerLatitude,
    "admin_fee": adminFee,
    "admin_payment_status": adminPaymentStatus,
    "otp": otp,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "profile_image": profileImage,
  };
}

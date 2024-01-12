// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

CustomerData customerDataFromJson(String str) => CustomerData.fromJson(json.decode(str));

String customerDataToJson(CustomerData data) => json.encode(data.toJson());

class CustomerData {
  String response;
  dynamic error;
  Data data;

  CustomerData({
    required this.response,
    required this.error,
    required this.data,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
    response: json["response"],
    error: json["error"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "error": error,
    "data": data.toJson(),
  };
}

class Data {
  int prevBookingId;
  String dId;
  String customerName;
  String userId;
  String pickupLocation;
  String dropLocation;
  double distance;
  int requestedBid;

  Data({
    required this.prevBookingId,
    required this.dId,
    required this.customerName,
    required this.userId,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    required this.requestedBid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    prevBookingId: json["prev_booking_id"],
    dId: json["d_id"],
    customerName: json["customer_name"],
    userId: json["user_id"],
    pickupLocation: json["pickup_location"],
    dropLocation: json["drop_location"],
    distance: json["distance"]?.toDouble(),
    requestedBid: json["requested_bid"],
  );

  Map<String, dynamic> toJson() => {
    "prev_booking_id": prevBookingId,
    "d_id": dId,
    "customer_name": customerName,
    "user_id": userId,
    "pickup_location": pickupLocation,
    "drop_location": dropLocation,
    "distance": distance,
    "requested_bid": requestedBid,
  };
}

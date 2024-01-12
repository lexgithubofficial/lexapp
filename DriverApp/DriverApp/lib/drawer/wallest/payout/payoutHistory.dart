// To parse this JSON data, do
//
//     final payoutHistory = payoutHistoryFromJson(jsonString);

import 'dart:convert';

PayoutHistory payoutHistoryFromJson(String str) => PayoutHistory.fromJson(json.decode(str));

String payoutHistoryToJson(PayoutHistory data) => json.encode(data.toJson());

class PayoutHistory {
  int status;
  List<Datum> data;

  PayoutHistory({
    required this.status,
    required this.data,
  });

  factory PayoutHistory.fromJson(Map<String, dynamic> json) => PayoutHistory(
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
  int confirmBookingsId;
  int dId;
  String amount;
  dynamic adminFee;
  String finalAmount;
  DateTime date;
  int status;
  dynamic clearedDate;

  Datum({
    required this.id,
    required this.confirmBookingsId,
    required this.dId,
    required this.amount,
    required this.adminFee,
    required this.finalAmount,
    required this.date,
    required this.status,
    required this.clearedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    confirmBookingsId: json["confirm_bookings_id"],
    dId: json["d_id"],
    amount: json["amount"],
    adminFee: json["admin_fee"],
    finalAmount: json["final_amount"],
    date: DateTime.parse(json["date"]),
    status: json["status"],
    clearedDate: json["cleared_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "confirm_bookings_id": confirmBookingsId,
    "d_id": dId,
    "amount": amount,
    "admin_fee": adminFee,
    "final_amount": finalAmount,
    "date": date.toIso8601String(),
    "status": status,
    "cleared_date": clearedDate,
  };
}

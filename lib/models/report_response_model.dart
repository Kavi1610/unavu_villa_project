class ReportResponseModel {
  bool? status;
  Data? data;
  String? message;

  ReportResponseModel({this.status, this.data, this.message});

  ReportResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? orderCompletedToday;
  int? orderCompletedWeek;
  int? orderCancelledToday;
  int? orderCancelledWeek;
  int? orderOngoingToday;
  int? orderOngoingWeek;

  Data(
      {this.orderCompletedToday,
      this.orderCompletedWeek,
      this.orderCancelledToday,
      this.orderCancelledWeek,
      this.orderOngoingToday,
      this.orderOngoingWeek});

  Data.fromJson(Map<String, dynamic> json) {
    orderCompletedToday = json['order_completed_today'];
    orderCompletedWeek = json['order_completed_week'];
    orderCancelledToday = json['order_cancelled_today'];
    orderCancelledWeek = json['order_cancelled_week'];
    orderOngoingToday = json['order_ongoing_today'];
    orderOngoingWeek = json['order_ongoing_week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_completed_today'] = orderCompletedToday;
    data['order_completed_week'] = orderCompletedWeek;
    data['order_cancelled_today'] = orderCancelledToday;
    data['order_cancelled_week'] = orderCancelledWeek;
    data['order_ongoing_today'] = orderOngoingToday;
    data['order_ongoing_week'] = orderOngoingWeek;
    return data;
  }
}

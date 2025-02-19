import 'dart:convert';

class FloorMasterResponse {
  final bool status;
  final Data data;
  final String message;

  FloorMasterResponse(
      {required this.status, required this.data, required this.message});

  factory FloorMasterResponse.fromJson(Map<String, dynamic> json) {
    return FloorMasterResponse(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final List<Item> items;
  final int total;
  final int page;
  final int size;
  final int pages;

  Data(
      {required this.items,
      required this.total,
      required this.page,
      required this.size,
      required this.pages});

  factory Data.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<Item> items = itemsList.map((i) => Item.fromJson(i)).toList();

    return Data(
      items: items,
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
    );
  }
}

class Item {
  final int? id; // Nullable
  final String? floorname; // Nullable
  final List<int>? departmentsid; // Nullable
  final bool? status; // Nullable
  final DateTime? createdAt; // Nullable
  final DateTime? updatedAt; // Nullable
  final bool? isDeleted; // Nullable

  Item({
    this.id, // Nullable
    this.floorname, // Nullable
    this.departmentsid, // Nullable
    this.status, // Nullable
    this.createdAt, // Nullable
    this.updatedAt, // Nullable
    this.isDeleted, // Nullable
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'], // Nullable
      floorname: json['floorname'], // Nullable
      departmentsid: json['departmentsid'] != null
          ? List<int>.from(json['departmentsid'])
          : null, // Nullable
      status: json['status'], // Nullable
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null, // Nullable
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null, // Nullable
      isDeleted: json['is_deleted'], // Nullable
    );
  }
}

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
  final int id;
  final String floorname;
  final List<int> departmentsid;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  Item({
    required this.id,
    required this.floorname,
    required this.departmentsid,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isDeleted,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      floorname: json['floorname'],
      departmentsid: List<int>.from(json['departmentsid']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isDeleted: json['is_deleted'],
    );
  }
}

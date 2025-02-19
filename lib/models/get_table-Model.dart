import 'dart:convert';

class TableResponse {
  final bool status;
  final Data data;
  final String message;

  TableResponse(
      {required this.status, required this.data, required this.message});

  factory TableResponse.fromJson(Map<String, dynamic> json) {
    return TableResponse(
      status: json['status'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  final List<TableItem> items;
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
    List<TableItem> items =
        itemsList.map((i) => TableItem.fromJson(i)).toList();

    return Data(
      items: items,
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
    );
  }
}

class TableItem {
  final int? id; // Nullable
  final int? branchId; // Nullable
  final String? tableId; // Nullable
  final String? tableType; // Nullable
  final int? floorId; // Nullable
  final bool? status; // Nullable
  final int? headCount; // Nullable
  final DateTime? createdAt; // Nullable
  final DateTime? updatedAt; // Nullable
  final dynamic deletedAt; // Can be null
  final bool? isDeleted; // Nullable

  TableItem({
    this.id, // Nullable
    this.branchId, // Nullable
    this.tableId, // Nullable
    this.tableType, // Nullable
    this.floorId, // Nullable
    this.status, // Nullable
    this.headCount, // Nullable
    this.createdAt, // Nullable
    this.updatedAt, // Nullable
    this.deletedAt, // Can be null
    this.isDeleted, // Nullable
  });

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
      id: json['id'], // Nullable
      branchId: json['branchid'], // Nullable
      tableId: json['tableid'], // Nullable
      tableType: json['tabletype'], // Nullable
      floorId: json['floorid'], // Nullable
      status: json['status'], // Nullable
      headCount: json['headcount'], // Nullable
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null, // Nullable
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null, // Nullable
      deletedAt: json['deleted_at'], // This can be null
      isDeleted: json['is_deleted'], // Nullable
    );
  }
}

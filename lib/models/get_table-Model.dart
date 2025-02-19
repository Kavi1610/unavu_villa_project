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
  final int id;
  final int branchId;
  final String tableId;
  final String tableType;
  final int floorId;
  final bool status;
  final int headCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt; // Can be null
  final bool isDeleted;

  TableItem({
    required this.id,
    required this.branchId,
    required this.tableId,
    required this.tableType,
    required this.floorId,
    required this.status,
    required this.headCount,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isDeleted,
  });

  factory TableItem.fromJson(Map<String, dynamic> json) {
    return TableItem(
      id: json['id'],
      branchId: json['branchid'],
      tableId: json['tableid'],
      tableType: json['tabletype'],
      floorId: json['floorid'],
      status: json['status'],
      headCount: json['headcount'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'], // This can be null
      isDeleted: json['is_deleted'],
    );
  }
}

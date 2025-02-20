// ignore_for_file: prefer_typing_uninitialized_variables

class OrderListResponse {
  bool? status;
  Data? data;
  String? message;

  OrderListResponse({this.status, this.data, this.message});

  OrderListResponse.fromJson(Map<String, dynamic> json) {
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
  List<Items>? items;
  var total;
  var page;
  var size;
  var pages;

  Data({this.items, this.total, this.page, this.size, this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    size = json['size'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['size'] = size;
    data['pages'] = pages;
    return data;
  }
}

class Items {
  var id;
  var ordertype;
  var billno;
  var orderid;
  var status;
  var tableid;
  String? numberofpeople;
  String? captainname;
  String? waitername;
  String? customername;
  String? customemobile;
  String? email;
  String? location;
  String? address;
  String? customerGSTIN;
  List<Items1>? items;
  var orderBy;
  String? knotes;
  var branchid;
  var floorid;
  var printerid;
  var discountamount;
  var totalamount;
  var grandtotal;
  String? createdAt;
  String? updatedAt;
  var deletedAt;
  bool? isDeleted;

  Items(
      {this.id,
      this.ordertype,
      this.billno,
      this.orderid,
      this.status,
      this.tableid,
      this.numberofpeople,
      this.captainname,
      this.waitername,
      this.customername,
      this.customemobile,
      this.email,
      this.location,
      this.address,
      this.customerGSTIN,
      this.items,
      this.orderBy,
      this.knotes,
      this.branchid,
      this.floorid,
      this.printerid,
      this.discountamount,
      this.totalamount,
      this.grandtotal,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isDeleted});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordertype = json['ordertype'];
    billno = json['billno'];
    orderid = json['orderid'];
    status = json['status'];
    tableid = json['tableid'];
    numberofpeople = json['numberofpeople'];
    captainname = json['captainname'];
    waitername = json['waitername'];
    customername = json['customername'];
    customemobile = json['customemobile'];
    email = json['email'];
    location = json['location'];
    address = json['address'];
    customerGSTIN = json['customerGSTIN'];
    if (json['items'] != null) {
      items = <Items1>[];
      json['items'].forEach((v) {
        items!.add(Items1.fromJson(v));
      });
    }
    orderBy = json['order_by'];
    knotes = json['knotes'];
    branchid = json['branchid'];
    floorid = json['floorid'];
    printerid = json['printerid'];
    discountamount = json['discountamount'];
    totalamount = json['totalamount'];
    grandtotal = json['grandtotal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ordertype'] = ordertype;
    data['billno'] = billno;
    data['orderid'] = orderid;
    data['status'] = status;
    data['tableid'] = tableid;
    data['numberofpeople'] = numberofpeople;
    data['captainname'] = captainname;
    data['waitername'] = waitername;
    data['customername'] = customername;
    data['customemobile'] = customemobile;
    data['email'] = email;
    data['location'] = location;
    data['address'] = address;
    data['customerGSTIN'] = customerGSTIN;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['order_by'] = orderBy;
    data['knotes'] = knotes;
    data['branchid'] = branchid;
    data['floorid'] = floorid;
    data['printerid'] = printerid;
    data['discountamount'] = discountamount;
    data['totalamount'] = totalamount;
    data['grandtotal'] = grandtotal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}

class Items1 {
  var id;
  var orderid;
  var itemcode;
  String? itemname;
  var quantity;
  var price;
  bool? comp;
  var total;
  String? taxType;
  var status;
  var statustime;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  var deletedAt;

  Items1(
      {this.id,
      this.orderid,
      this.itemcode,
      this.itemname,
      this.quantity,
      this.price,
      this.comp,
      this.total,
      this.taxType,
      this.status,
      this.statustime,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Items1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderid = json['orderid'];
    itemcode = json['itemcode'];
    itemname = json['itemname'];
    quantity = json['quantity'];
    price = json['price'];
    comp = json['comp'];
    total = json['total'];
    taxType = json['tax_type'];
    status = json['status'];
    statustime = json['statustime'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['orderid'] = orderid;
    data['itemcode'] = itemcode;
    data['itemname'] = itemname;
    data['quantity'] = quantity;
    data['price'] = price;
    data['comp'] = comp;
    data['total'] = total;
    data['tax_type'] = taxType;
    data['status'] = status;
    data['statustime'] = statustime;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class GetMenuItem {
  final bool status;
  final MenuData data;

  GetMenuItem({
    required this.status,
    required this.data,
  });

  factory GetMenuItem.fromJson(Map<String, dynamic> json) => GetMenuItem(
        status: json["status"],
        data: MenuData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class MenuData {
  final List<MenuItem> items;

  MenuData({
    required this.items,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
        items:
            List<MenuItem>.from(json["items"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class MenuItem {
  final int id;
  final String itemname;
  final String menucode;
  final String price;
  final String menuname;
  final String deptname;
  final String acdineintax;
  final String nonacdineintax;
  final String tawaytax;
  final String delivtax;
  final String roomservtax;
  final String selfservicetax;
  final String acprice;
  final String parcelprice;
  final String deliveryprice;
  final String roomprice;
  final String selfserprice;
  final String floorid;
  final String menuid;
  final String itemparent;
  final String image;
  final String largeimage;
  final String adminimage;
  final String itemstatus;
  final String itemhide;
  final String rewardpoints;
  final dynamic printertype;
  final String itemtype;
  final String kotitemname;
  final String printupon;
  final String combotype;
  final String custkot;
  final String dineintax;
  final String taxitem;
  final String prodenable;
  final String happyprice;
  final String happyacprice;
  final String happytakeprice;
  final String happydelprice;
  final String happyroomprice;
  final String happyselfprice;
  final dynamic treat;
  final String itemcombotype;
  final dynamic calories;
  final String packingcharge;
  final String includediscount;
  final String includetaxwithprice;
  final String qtycutting;
  final String ismrp;
  final dynamic packingchargeid;
  final dynamic chefid;
  final String servingportion;
  final String spicylevel;
  final String hasaddon;
  final String synctype;
  final String delavailable;
  final String takeavailable;
  final dynamic qrdescription;
  final String isupmenu;
  final String isqrmenu;
  final String qrstatus;
  final String uomid;
  final String sweetlevel;
  final String gravyproperty;
  final String boneproperty;
  final String seasonalingredients;
  final dynamic accompaniments;
  final String brandid;
  final String preorderstatus;
  final String barcode;
  final String stocktype;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final bool isDeleted;

  MenuItem({
    required this.id,
    required this.itemname,
    required this.menucode,
    required this.price,
    required this.menuname,
    required this.deptname,
    required this.acdineintax,
    required this.nonacdineintax,
    required this.tawaytax,
    required this.delivtax,
    required this.roomservtax,
    required this.selfservicetax,
    required this.acprice,
    required this.parcelprice,
    required this.deliveryprice,
    required this.roomprice,
    required this.selfserprice,
    required this.floorid,
    required this.menuid,
    required this.itemparent,
    required this.image,
    required this.largeimage,
    required this.adminimage,
    required this.itemstatus,
    required this.itemhide,
    required this.rewardpoints,
    required this.printertype,
    required this.itemtype,
    required this.kotitemname,
    required this.printupon,
    required this.combotype,
    required this.custkot,
    required this.dineintax,
    required this.taxitem,
    required this.prodenable,
    required this.happyprice,
    required this.happyacprice,
    required this.happytakeprice,
    required this.happydelprice,
    required this.happyroomprice,
    required this.happyselfprice,
    required this.treat,
    required this.itemcombotype,
    required this.calories,
    required this.packingcharge,
    required this.includediscount,
    required this.includetaxwithprice,
    required this.qtycutting,
    required this.ismrp,
    required this.packingchargeid,
    required this.chefid,
    required this.servingportion,
    required this.spicylevel,
    required this.hasaddon,
    required this.synctype,
    required this.delavailable,
    required this.takeavailable,
    required this.qrdescription,
    required this.isupmenu,
    required this.isqrmenu,
    required this.qrstatus,
    required this.uomid,
    required this.sweetlevel,
    required this.gravyproperty,
    required this.boneproperty,
    required this.seasonalingredients,
    required this.accompaniments,
    required this.brandid,
    required this.preorderstatus,
    required this.barcode,
    required this.stocktype,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isDeleted,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["id"],
        itemname: json["itemname"],
        menucode: json["menucode"],
        price: json["price"],
        menuname: json["menuname"],
        deptname: json["deptname"],
        acdineintax: json["acdineintax"],
        nonacdineintax: json["nonacdineintax"],
        tawaytax: json["tawaytax"],
        delivtax: json["delivtax"],
        roomservtax: json["roomservtax"],
        selfservicetax: json["selfservicetax"],
        acprice: json["acprice"],
        parcelprice: json["parcelprice"],
        deliveryprice: json["deliveryprice"],
        roomprice: json["roomprice"],
        selfserprice: json["selfserprice"],
        floorid: json["floorid"],
        menuid: json["menuid"],
        itemparent: json["itemparent"],
        image: json["image"],
        largeimage: json["largeimage"],
        adminimage: json["adminimage"],
        itemstatus: json["itemstatus"],
        itemhide: json["itemhide"],
        rewardpoints: json["rewardpoints"],
        printertype: json["printertype"],
        itemtype: json["itemtype"],
        kotitemname: json["kotitemname"],
        printupon: json["printupon"],
        combotype: json["combotype"],
        custkot: json["custkot"],
        dineintax: json["dineintax"],
        taxitem: json["taxitem"],
        prodenable: json["prodenable"],
        happyprice: json["happyprice"],
        happyacprice: json["happyacprice"],
        happytakeprice: json["happytakeprice"],
        happydelprice: json["happydelprice"],
        happyroomprice: json["happyroomprice"],
        happyselfprice: json["happyselfprice"],
        treat: json["treat"],
        itemcombotype: json["itemcombotype"],
        calories: json["calories"],
        packingcharge: json["packingcharge"],
        includediscount: json["includediscount"],
        includetaxwithprice: json["includetaxwithprice"],
        qtycutting: json["qtycutting"],
        ismrp: json["ismrp"],
        packingchargeid: json["packingchargeid"],
        chefid: json["chefid"],
        servingportion: json["servingportion"],
        spicylevel: json["spicylevel"],
        hasaddon: json["hasaddon"],
        synctype: json["synctype"],
        delavailable: json["delavailable"],
        takeavailable: json["takeavailable"],
        qrdescription: json["qrdescription"],
        isupmenu: json["isupmenu"],
        isqrmenu: json["isqrmenu"],
        qrstatus: json["qrstatus"],
        uomid: json["uomid"],
        sweetlevel: json["sweetlevel"],
        gravyproperty: json["gravyproperty"],
        boneproperty: json["boneproperty"],
        seasonalingredients: json["seasonalingredients"],
        accompaniments: json["accompaniments"],
        brandid: json["brandid"],
        preorderstatus: json["preorderstatus"],
        barcode: json["barcode"],
        stocktype: json["stocktype"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemname": itemname,
        "menucode": menucode,
        "price": price,
        "menuname": menuname,
        "deptname": deptname,
        "acdineintax": acdineintax,
        "nonacdineintax": nonacdineintax,
        "tawaytax": tawaytax,
        "delivtax": delivtax,
        "roomservtax": roomservtax,
        "selfservicetax": selfservicetax,
        "acprice": acprice,
        "parcelprice": parcelprice,
        "deliveryprice": deliveryprice,
        "roomprice": roomprice,
        "selfserprice": selfserprice,
        "floorid": floorid,
        "menuid": menuid,
        "itemparent": itemparent,
        "image": image,
        "largeimage": largeimage,
        "adminimage": adminimage,
        "itemstatus": itemstatus,
        "itemhide": itemhide,
        "rewardpoints": rewardpoints,
        "printertype": printertype,
        "itemtype": itemtype,
        "kotitemname": kotitemname,
        "printupon": printupon,
        "combotype": combotype,
        "custkot": custkot,
        "dineintax": dineintax,
        "taxitem": taxitem,
        "prodenable": prodenable,
        "happyprice": happyprice,
        "happyacprice": happyacprice,
        "happytakeprice": happytakeprice,
        "happydelprice": happydelprice,
        "happyroomprice": happyroomprice,
        "happyselfprice": happyselfprice,
        "treat": treat,
        "itemcombotype": itemcombotype,
        "calories": calories,
        "packingcharge": packingcharge,
        "includediscount": includediscount,
        "includetaxwithprice": includetaxwithprice,
        "qtycutting": qtycutting,
        "ismrp": ismrp,
        "packingchargeid": packingchargeid,
        "chefid": chefid,
        "servingportion": servingportion,
        "spicylevel": spicylevel,
        "hasaddon": hasaddon,
        "synctype": synctype,
        "delavailable": delavailable,
        "takeavailable": takeavailable,
        "qrdescription": qrdescription,
        "isupmenu": isupmenu,
        "isqrmenu": isqrmenu,
        "qrstatus": qrstatus,
        "uomid": uomid,
        "sweetlevel": sweetlevel,
        "gravyproperty": gravyproperty,
        "boneproperty": boneproperty,
        "seasonalingredients": seasonalingredients,
        "accompaniments": accompaniments,
        "brandid": brandid,
        "preorderstatus": preorderstatus,
        "barcode": barcode,
        "stocktype": stocktype,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "is_deleted": isDeleted,
      };
}

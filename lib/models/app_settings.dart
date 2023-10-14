
class AppSettings {
  int currentPage;
  int totalPages;
  int totalItems;
  int itemsPerPage;
  List<Item> items;

  AppSettings({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.items,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    currentPage: json["CurrentPage"],
    totalPages: json["TotalPages"],
    totalItems: json["TotalItems"],
    itemsPerPage: json["ItemsPerPage"],
    items: List<Item>.from(json["Items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "CurrentPage": currentPage,
    "TotalPages": totalPages,
    "TotalItems": totalItems,
    "ItemsPerPage": itemsPerPage,
    "Items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  String key;
  String value;
  int addedBy;
  int modifiedBy;
  DateTime modifiedOn;
  DateTime addedOn;
  bool isPublic;

  Item({
    required this.id,
    required this.key,
    required this.value,
    required this.addedBy,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.addedOn,
    required this.isPublic,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["Id"],
    key: json["Key"],
    value: json["Value"],
    addedBy: json["AddedBy"],
    modifiedBy: json["ModifiedBy"],
    modifiedOn: DateTime.parse(json["ModifiedOn"]),
    addedOn: DateTime.parse(json["AddedOn"]),
    isPublic: json["IsPublic"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Key": key,
    "Value": value,
    "AddedBy": addedBy,
    "ModifiedBy": modifiedBy,
    "ModifiedOn": modifiedOn.toIso8601String(),
    "AddedOn": addedOn.toIso8601String(),
    "IsPublic": isPublic,
  };
}

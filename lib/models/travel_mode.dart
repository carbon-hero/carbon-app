// To parse this JSON data, do
//
//     final travel = travelFromJson(jsonString);

import 'dart:convert';

List<Travel> travelFromJson(String str) => List<Travel>.from(json.decode(str).map((x) => Travel.fromJson(x)));

String travelToJson(List<Travel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Travel {
  int id;
  int typeId;
  String value;
  int addedBy;
  int modifiedBy;
  DateTime addedOn;
  DateTime modifiedOn;
  String dataTypeName;

  Travel({
    required this.id,
    required this.typeId,
    required this.value,
    required this.addedBy,
    required this.modifiedBy,
    required this.addedOn,
    required this.modifiedOn,
    required this.dataTypeName,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
    id: json["id"],
    typeId: json["typeId"],
    value: json["value"],
    addedBy: json["addedBy"],
    modifiedBy: json["modifiedBy"],
    addedOn: DateTime.parse(json["addedOn"]),
    modifiedOn: DateTime.parse(json["modifiedOn"]),
    dataTypeName: json["dataTypeName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "typeId": typeId,
    "value": value,
    "addedBy": addedBy,
    "modifiedBy": modifiedBy,
    "addedOn": addedOn.toIso8601String(),
    "modifiedOn": modifiedOn.toIso8601String(),
    "dataTypeName": dataTypeName,
  };
}

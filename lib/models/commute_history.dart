
class CommuteHistory {
  int id;
  String fromPlaceId;
  double fromLat;
  double fromLong;
  String toPlaceId;
  double toLat;
  double toLong;
  int distance;
  String distanceMapUrl;
  String friendIds;
  int carbonEmission;
  int modeId;
  int typeId;
  int addedBy;
  int modifiedBy;
  DateTime addedOn;
  DateTime modifiedOn;
  String modeName;
  String typeName;
  dynamic createdBy;
  String fromAddress;
  String toAddress;
  List<dynamic> friends;

  CommuteHistory({
    required this.id,
    required this.fromPlaceId,
    required this.fromLat,
    required this.fromLong,
    required this.toPlaceId,
    required this.toLat,
    required this.toLong,
    required this.distance,
    required this.distanceMapUrl,
    required this.friendIds,
    required this.carbonEmission,
    required this.modeId,
    required this.typeId,
    required this.addedBy,
    required this.modifiedBy,
    required this.addedOn,
    required this.modifiedOn,
    required this.modeName,
    required this.typeName,
    required this.createdBy,
    required this.fromAddress,
    required this.toAddress,
    required this.friends,
  });

  factory CommuteHistory.fromJson(Map<String, dynamic> json) => CommuteHistory(
    id: json["id"],
    fromPlaceId: json["fromPlaceId"],
    fromLat: json["fromLat"]?.toDouble(),
    fromLong: json["fromLong"]?.toDouble(),
    toPlaceId: json["toPlaceId"],
    toLat: json["toLat"]?.toDouble(),
    toLong: json["toLong"]?.toDouble(),
    distance: json["distance"],
    distanceMapUrl: json["distanceMapURL"],
    friendIds: json["friendIds"],
    carbonEmission: json["carbonEmission"],
    modeId: json["modeId"],
    typeId: json["typeId"],
    addedBy: json["addedBy"],
    modifiedBy: json["modifiedBy"],
    addedOn: DateTime.parse(json["addedOn"]),
    modifiedOn: DateTime.parse(json["modifiedOn"]),
    modeName: json["modeName"],
    typeName: json["typeName"],
    createdBy: json["createdBy"],
    fromAddress: json["fromAddress"],
    toAddress: json["toAddress"],
    friends: List<dynamic>.from(json["friends"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fromPlaceId": fromPlaceId,
    "fromLat": fromLat,
    "fromLong": fromLong,
    "toPlaceId": toPlaceId,
    "toLat": toLat,
    "toLong": toLong,
    "distance": distance,
    "distanceMapURL": distanceMapUrl,
    "friendIds": friendIds,
    "carbonEmission": carbonEmission,
    "modeId": modeId,
    "typeId": typeId,
    "addedBy": addedBy,
    "modifiedBy": modifiedBy,
    "addedOn": addedOn.toIso8601String(),
    "modifiedOn": modifiedOn.toIso8601String(),
    "modeName": modeName,
    "typeName": typeName,
    "createdBy": createdBy,
    "fromAddress": fromAddress,
    "toAddress": toAddress,
    "friends": List<dynamic>.from(friends.map((x) => x)),
  };
}

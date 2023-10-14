
class User {
  int id;
  String firstName;
  String lastName;
  String homeAddress;
  dynamic homeLat;
  dynamic homeLong;
  String officeAddress;
  dynamic officeLat;
  dynamic officeLong;
  String email;
  int treesPlanted;
  String password;
  int profilePicId;
  bool isActive;
  int addedBy;
  int modifiedBy;
  DateTime addedOn;
  DateTime modifiedOn;
  String phoneNumber;
  String fullName;
  String token;
  dynamic fileUrl;
  String fullFileUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.homeAddress,
    required this.homeLat,
    required this.homeLong,
    required this.officeAddress,
    required this.officeLat,
    required this.officeLong,
    required this.email,
    required this.treesPlanted,
    required this.password,
    required this.profilePicId,
    required this.isActive,
    required this.addedBy,
    required this.modifiedBy,
    required this.addedOn,
    required this.modifiedOn,
    required this.phoneNumber,
    required this.fullName,
    required this.token,
    required this.fileUrl,
    required this.fullFileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    homeAddress: json["homeAddress"],
    homeLat: json["homeLat"],
    homeLong: json["homeLong"],
    officeAddress: json["officeAddress"],
    officeLat: json["officeLat"],
    officeLong: json["officeLong"],
    email: json["email"],
    treesPlanted: json["treesPlanted"],
    password: json["password"],
    profilePicId: json["profilePicId"],
    isActive: json["isActive"],
    addedBy: json["addedBy"],
    modifiedBy: json["modifiedBy"],
    addedOn: DateTime.parse(json["addedOn"]),
    modifiedOn: DateTime.parse(json["modifiedOn"]),
    phoneNumber: json["phoneNumber"],
    fullName: json["fullName"],
    token: json["token"],
    fileUrl: json["fileUrl"],
    fullFileUrl: json["fullFileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "homeAddress": homeAddress,
    "homeLat": homeLat,
    "homeLong": homeLong,
    "officeAddress": officeAddress,
    "officeLat": officeLat,
    "officeLong": officeLong,
    "email": email,
    "treesPlanted": treesPlanted,
    "password": password,
    "profilePicId": profilePicId,
    "isActive": isActive,
    "addedBy": addedBy,
    "modifiedBy": modifiedBy,
    "addedOn": addedOn.toIso8601String(),
    "modifiedOn": modifiedOn.toIso8601String(),
    "phoneNumber": phoneNumber,
    "fullName": fullName,
    "token": token,
    "fileUrl": fileUrl,
    "fullFileUrl": fullFileUrl,
  };
}

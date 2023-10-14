class Prediction {
  Prediction({
    this.description,
    this.placeId,
  });


  String? description;
  String? placeId;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    description: json["description"],
    placeId: json["place_id"],
    );

  Map<String, dynamic> toJson() => {
    "description": description,
    "place_id": placeId,
     };
}


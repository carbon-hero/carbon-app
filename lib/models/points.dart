
class Points {
  int earned;
  int spent;
  int balance;

  Points({
    required this.earned,
    required this.spent,
    required this.balance,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    earned: json["earned"],
    spent: json["spent"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "earned": earned,
    "spent": spent,
    "balance": balance,
  };
}

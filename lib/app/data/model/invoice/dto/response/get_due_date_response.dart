class GetDueDateResponse {
  GetDueDateResponse({
    required this.type,
    required this.dayNumber,
    required this.dueDate,
  });

  final String type;
  final int dayNumber;
  DateTime dueDate;

  factory GetDueDateResponse.fromJson(Map<String, dynamic> json) => GetDueDateResponse(
    type: json["type"],
    dayNumber: json["dayNumber"],
    dueDate: DateTime.parse(json["dueDate"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "dayNumber": dayNumber,
    "dueDate": dueDate.toIso8601String(),
  };
}

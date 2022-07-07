import 'dart:convert';

DataModelPut dataModelFromJson(String str) =>
    DataModelPut.fromJson(json.decode(str));

String dataModelToJson(DataModelPut data) => json.encode(data.toJson());

class DataModelPut {
  DataModelPut({
    required this.name,
    required this.job,
    required this.updatedAt,
  });

  String name;
  String job;
  DateTime updatedAt;

  factory DataModelPut.fromJson(Map<String, dynamic> json) => DataModelPut(
        name: json["name"],
        job: json["job"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

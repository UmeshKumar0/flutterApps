// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
    ItemModel({
        required this.dateRange,
        required this.currentDate,
        required this.description,
        required this.compatibility,
        required this.mood,
        required this.color,
        required this.luckyNumber,
        required this.luckyTime,
    });

    String dateRange;
    String currentDate;
    String description;
    String compatibility;
    String mood;
    String color;
    String luckyNumber;
    String luckyTime;

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        dateRange: json["date_range"],
        currentDate: json["current_date"],
        description: json["description"],
        compatibility: json["compatibility"],
        mood: json["mood"],
        color: json["color"],
        luckyNumber: json["lucky_number"],
        luckyTime: json["lucky_time"],
    );

    Map<String, dynamic> toJson() => {
        "date_range": dateRange,
        "current_date": currentDate,
        "description": description,
        "compatibility": compatibility,
        "mood": mood,
        "color": color,
        "lucky_number": luckyNumber,
        "lucky_time": luckyTime,
    };
}
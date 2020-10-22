// To parse this JSON data, do
//
//     final routesModel = routesModelFromJson(jsonString);

import 'dart:convert';

List<RoutesModel> routesModelFromJson(String str) => List<RoutesModel>.from(json.decode(str).map((x) => RoutesModel.fromJson(x)));

String routesModelToJson(List<RoutesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoutesModel {
    RoutesModel({
        this.id,
        this.name,
        this.description,
        this.enabled,
        this.company,
        this.coordinates,
    });

    int id;
    String name;
    String description;
    bool enabled;
    dynamic company;
    List<Coordinate> coordinates;

    factory RoutesModel.fromJson(Map<String, dynamic> json) => RoutesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        enabled: json["enabled"],
        company: json["company"],
        coordinates: List<Coordinate>.from(json["coordinates"].map((x) => Coordinate.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "enabled": enabled,
        "company": company,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x.toJson())),
    };
}

class Coordinate {
    Coordinate({
        this.latitude,
        this.length,
    });

    double latitude;
    double length;

    factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        latitude: json["latitude"].toDouble(),
        length: json["length"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "length": length,
    };
}

// To parse this JSON data, do
//
//     final coordModel = coordModelFromJson(jsonString);

import 'dart:convert';

CoordModel coordModelFromJson(String str) => CoordModel.fromJson(json.decode(str));

String coordModelToJson(CoordModel data) => json.encode(data.toJson());

class CoordModel {
    CoordModel({
        this.coordinates,
    });

    List<List<double>> coordinates;

    factory CoordModel.fromJson(Map<String, dynamic> json) => CoordModel(
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}

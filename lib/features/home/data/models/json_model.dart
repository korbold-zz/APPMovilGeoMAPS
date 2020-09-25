// To parse this JSON data, do
//
//     final rutasModel = rutasModelFromJson(jsonString);

import 'dart:convert';

List<RutasModel> rutasModelFromJson(String str) => List<RutasModel>.from(json.decode(str).map((x) => RutasModel.fromJson(x)));

String rutasModelToJson(List<RutasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutasModel {
    RutasModel({
        this.id,
        this.name,
        this.description,
        this.enabled,
        this.journey,
        this.journeyContentType,
        this.journeyOptional,
        this.company,
    });

    int id;
    String name;
    String description;
    bool enabled;
    dynamic journey;
    dynamic journeyContentType;
    String journeyOptional;
    Company company;

    factory RutasModel.fromJson(Map<String, dynamic> json) => RutasModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        enabled: json["enabled"],
        journey: json["journey"],
        journeyContentType: json["journeyContentType"],
        journeyOptional: json["journeyOptional"],
        company: Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "enabled": enabled,
        "journey": journey,
        "journeyContentType": journeyContentType,
        "journeyOptional": journeyOptional,
        "company": company.toJson(),
    };
}

class Company {
    Company({
        this.id,
        this.name,
        this.legalRepresentative,
        this.dni,
        this.enabled,
        this.companyType,
    });

    int id;
    String name;
    String legalRepresentative;
    String dni;
    bool enabled;
    CompanyType companyType;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        legalRepresentative: json["legalRepresentative"],
        dni: json["dni"],
        enabled: json["enabled"],
        companyType: CompanyType.fromJson(json["companyType"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "legalRepresentative": legalRepresentative,
        "dni": dni,
        "enabled": enabled,
        "companyType": companyType.toJson(),
    };
}

class CompanyType {
    CompanyType({
        this.id,
        this.name,
        this.description,
    });

    int id;
    String name;
    String description;

    factory CompanyType.fromJson(Map<String, dynamic> json) => CompanyType(
        id: json["id"],
        name: json["name"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
    };
}

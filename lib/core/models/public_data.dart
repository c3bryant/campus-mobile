// To parse this JSON data, do
//
//     final publicDataModel = publicDataModelFromJson(jsonString);

import 'dart:convert';

PublicDataModel publicDataModelFromJson(String str) =>
    PublicDataModel.fromJson(json.decode(str));

String publicDataModelToJson(PublicDataModel data) =>
    json.encode(data.toJson());

class PublicDataModel {
  PublicDataModel({
    this.accessToken,
    this.scope,
    this.tokenType,
    this.expiresIn,
  });

  String accessToken;
  String scope;
  String tokenType;
  int expiresIn;

  factory PublicDataModel.fromJson(Map<String, dynamic> json) =>
      PublicDataModel(
        accessToken: json["access_token"] == null ? null : json["access_token"],
        scope: json["scope"] == null ? null : json["scope"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
        expiresIn: json["expires_in"] == null ? null : json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken == null ? null : accessToken,
        "scope": scope == null ? null : scope,
        "token_type": tokenType == null ? null : tokenType,
        "expires_in": expiresIn == null ? null : expiresIn,
      };
}

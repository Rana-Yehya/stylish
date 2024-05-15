import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String email;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? password;
  String? phone;
  @JsonKey(includeToJson: false, name: "created_at")
  String? createdAt;
  String? image;
  double? lat;
  double? lng;
  bool? emailConfirmedAt;
  UserModel({
    this.id,
    required this.email,
    this.password,
    this.phone,
    this.createdAt,
    this.image,
    this.lat,
    this.lng,
    this.emailConfirmedAt,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

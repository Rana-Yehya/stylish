import 'package:json_annotation/json_annotation.dart';

part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel {
  @JsonKey(includeToJson: false, includeFromJson: true)
  int? id;
  String? image;
  @JsonKey(includeToJson: false, name: "created_at")
  String? createdAt;
  List<String>? category;
  BlogModel({
    this.id,
    this.image,
    this.createdAt,
    this.category,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}

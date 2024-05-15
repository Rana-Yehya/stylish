import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(includeToJson: false, includeFromJson: true)
  int? id;
  String? name;
  String? company;
  num? price;
  String? description;
  @JsonKey(includeToJson: false, name: "created_at")
  String? createdAt;
  num? sale;
  List<String>? images;
  @JsonKey(name: "shoes_size")
  List<String>? shoesSize;
  List<String>? color;
  List<String>? category;
  List<String>? size;
  ProductModel({
    this.id,
    this.name,
    this.company,
    this.price,
    this.description,
    this.createdAt,
    this.sale,
    this.images,
    this.shoesSize,
    this.color,
    this.category,
    this.size,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

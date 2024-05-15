import 'package:json_annotation/json_annotation.dart';

part 'paid_item_product_model.g.dart';

@JsonSerializable()
class PaidItemProductModel {
  @JsonKey(includeToJson: false, includeFromJson: true)
  int? id;
  @JsonKey(includeToJson: false, name: "product_id")
  List<int>? productId;
  List<String>? name;
  List<int>? quantity;
  List<String>? colors;
  List<String>? size;

  PaidItemProductModel({
    this.id,
    this.productId,
    this.name,
    this.quantity,
    this.colors,
    this.size,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PaidItemProductModel.fromJson(Map<String, dynamic> json) =>
      _$PaidItemProductModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaidItemProductModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'medicine_model.g.dart';

@JsonSerializable()
class Medicine {
  @JsonKey(name: 'id', defaultValue: 0)
  num? id;

  @JsonKey(name: 'name', defaultValue: '')
  String name;

  @JsonKey(name: 'description', defaultValue: '')
  String description;

  @JsonKey(name: 'imageUrl', defaultValue: '')
  String imageUrl;

  @JsonKey(name: 'price', defaultValue: 0)
  num price;

  @JsonKey(name: 'quantity', defaultValue: 0)
  num quantity;

  Medicine({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) => Medicine(
      id: json['id'] as num? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
      quantity: json['quantity'] as num? ?? 0,
    );

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      // 'id': instance.id,
      'Name': instance.name,
      'Description': instance.description,
      'ImageUrl': instance.imageUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };

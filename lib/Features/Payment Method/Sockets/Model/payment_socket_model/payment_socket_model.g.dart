// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_socket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSocketModel _$PaymentSocketModelFromJson(Map<String, dynamic> json) =>
    PaymentSocketModel(
      message: json['message'] as String?,
      transaction: json['transaction'] == null
          ? null
          : Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentSocketModelToJson(PaymentSocketModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'transaction': instance.transaction,
    };

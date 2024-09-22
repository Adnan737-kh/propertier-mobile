// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['id'] as num?)?.toInt(),
      paymobId: json['paymob_id'] as String?,
      transactionId: json['transaction_id'],
      paymentMethodId: json['payment_method_id'],
      integrationId: json['integration_id'],
      orderId: json['order_id'],
      currency: json['currency'] as String?,
      cardNumber: json['card_number'],
      cardSubType: json['card_sub_type'],
      txnResponseCode: json['txn_response_code'],
      message: json['message'],
      hmac: json['hmac'],
      paymobSpecialReference: json['paymob_special_reference'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      status: json['status'] as String?,
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymob_id': instance.paymobId,
      'transaction_id': instance.transactionId,
      'payment_method_id': instance.paymentMethodId,
      'integration_id': instance.integrationId,
      'order_id': instance.orderId,
      'currency': instance.currency,
      'card_number': instance.cardNumber,
      'card_sub_type': instance.cardSubType,
      'txn_response_code': instance.txnResponseCode,
      'message': instance.message,
      'hmac': instance.hmac,
      'paymob_special_reference': instance.paymobSpecialReference,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'status': instance.status,
      'user': instance.user,
    };

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  final int? id;
  @JsonKey(name: 'paymob_id')
  final String? paymobId;
  @JsonKey(name: 'transaction_id')
  final dynamic transactionId;
  @JsonKey(name: 'payment_method_id')
  final dynamic paymentMethodId;
  @JsonKey(name: 'integration_id')
  final dynamic integrationId;
  @JsonKey(name: 'order_id')
  final dynamic orderId;
  final String? currency;
  @JsonKey(name: 'card_number')
  final dynamic cardNumber;
  @JsonKey(name: 'card_sub_type')
  final dynamic cardSubType;
  @JsonKey(name: 'txn_response_code')
  final dynamic txnResponseCode;
  final dynamic message;
  final dynamic hmac;
  @JsonKey(name: 'paymob_special_reference')
  final String? paymobSpecialReference;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  final String? status;
  final int? user;

  const Transaction({
    this.id,
    this.paymobId,
    this.transactionId,
    this.paymentMethodId,
    this.integrationId,
    this.orderId,
    this.currency,
    this.cardNumber,
    this.cardSubType,
    this.txnResponseCode,
    this.message,
    this.hmac,
    this.paymobSpecialReference,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.user,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, paymobId: $paymobId, transactionId: $transactionId, paymentMethodId: $paymentMethodId, integrationId: $integrationId, orderId: $orderId, currency: $currency, cardNumber: $cardNumber, cardSubType: $cardSubType, txnResponseCode: $txnResponseCode, message: $message, hmac: $hmac, paymobSpecialReference: $paymobSpecialReference, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, user: $user)';
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return _$TransactionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  Transaction copyWith({
    int? id,
    String? paymobId,
    dynamic transactionId,
    dynamic paymentMethodId,
    dynamic integrationId,
    dynamic orderId,
    String? currency,
    dynamic cardNumber,
    dynamic cardSubType,
    dynamic txnResponseCode,
    dynamic message,
    dynamic hmac,
    String? paymobSpecialReference,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? status,
    int? user,
  }) {
    return Transaction(
      id: id ?? this.id,
      paymobId: paymobId ?? this.paymobId,
      transactionId: transactionId ?? this.transactionId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      integrationId: integrationId ?? this.integrationId,
      orderId: orderId ?? this.orderId,
      currency: currency ?? this.currency,
      cardNumber: cardNumber ?? this.cardNumber,
      cardSubType: cardSubType ?? this.cardSubType,
      txnResponseCode: txnResponseCode ?? this.txnResponseCode,
      message: message ?? this.message,
      hmac: hmac ?? this.hmac,
      paymobSpecialReference:
          paymobSpecialReference ?? this.paymobSpecialReference,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Transaction) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      paymobId.hashCode ^
      transactionId.hashCode ^
      paymentMethodId.hashCode ^
      integrationId.hashCode ^
      orderId.hashCode ^
      currency.hashCode ^
      cardNumber.hashCode ^
      cardSubType.hashCode ^
      txnResponseCode.hashCode ^
      message.hashCode ^
      hmac.hashCode ^
      paymobSpecialReference.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      status.hashCode ^
      user.hashCode;
}

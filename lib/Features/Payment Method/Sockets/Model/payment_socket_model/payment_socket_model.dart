import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'transaction.dart';

part 'payment_socket_model.g.dart';

@JsonSerializable()
class PaymentSocketModel {
  final String? message;
  final Transaction? transaction;

  const PaymentSocketModel({this.message, this.transaction});

  @override
  String toString() {
    return 'PaymentSocketModel(message: $message, transaction: $transaction)';
  }

  factory PaymentSocketModel.fromJson(Map<String, dynamic> json) {
    return _$PaymentSocketModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentSocketModelToJson(this);

  PaymentSocketModel copyWith({
    String? message,
    Transaction? transaction,
  }) {
    return PaymentSocketModel(
      message: message ?? this.message,
      transaction: transaction ?? this.transaction,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PaymentSocketModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode ^ transaction.hashCode;
}

enum PaymentMethodType {
  card,
  klarna,
}


extension PaymentMethodTypeMapperExt on PaymentMethodType {
  String toDtoType() => switch (this) {
    PaymentMethodType.card => 'card',
    PaymentMethodType.klarna => 'klarna',
  };
}

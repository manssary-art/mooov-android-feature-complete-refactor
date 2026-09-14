import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:network_api/apis/payment_card_api.dart';
import 'package:network_api/ext/http_response_ext.dart';

import 'saved_payment_method_repository.dart';

class SavedPaymentMethodRepositoryImpl implements SavedPaymentMethodRepository {
  final PaymentCardApi paymentCardApi;

  SavedPaymentMethodRepositoryImpl({
    required this.paymentCardApi,
  });

  @override
  Future<Result<void>> deleteSavedCard({
    required String id,
  }) =>
      resultOf(() async {
        return paymentCardApi.deleteSavedCard(id: id).asHttpResponseResult();
      });

  @override
  Future<Result<List<SavedCardInfoModel>>> getSavedCard() => resultOf(() async {
        return paymentCardApi
            .getSavedCards()
            .asHttpResponseResult()
            .mapValue((value) => value.mapNotNull<SavedCardInfoModel>((e) {
                  final card = e.card;
                  if (card == null) return null;
                  return (id: e.id, last4: card.last4, brand: card.brand);
                }).toList());
      });
}

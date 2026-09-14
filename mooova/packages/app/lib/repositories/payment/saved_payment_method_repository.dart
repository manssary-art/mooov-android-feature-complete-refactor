import 'package:async/async.dart';

typedef SavedCardInfoModel = ({String id, String last4, String brand});

abstract class SavedPaymentMethodRepository {
  Future<Result<List<SavedCardInfoModel>>> getSavedCard();

  Future<Result<void>> deleteSavedCard({required String id});
}

import 'package:async/async.dart';
import 'package:cross_file/cross_file.dart';

enum UploadFolderType {
  product('product'),
  profile('profile'),
  vehicle('vehicle'),
  document('document');

  final String value;

  const UploadFolderType(this.value);
}

typedef DownloadUrl = String;

abstract interface class UploadRepository {
  Future<Result<DownloadUrl>> upload({
    required XFile file,
    required UploadFolderType type,
  });
}

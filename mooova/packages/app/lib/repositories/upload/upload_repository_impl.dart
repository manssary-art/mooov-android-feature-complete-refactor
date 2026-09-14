import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../user/user_repository.dart';
import 'upload_repository.dart';

final String _fallback = DateTime.now().millisecondsSinceEpoch.toString();

class UploadRepositoryImpl implements UploadRepository {
  final FirebaseStorage firebaseStorage;
  final UserRepository userRepository;

  const UploadRepositoryImpl({
    required this.firebaseStorage,
    required this.userRepository,
  });

  @override
  Future<Result<DownloadUrl>> upload({
    required XFile file,
    required UploadFolderType type,
  }) =>
      resultOf(() async {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        return await userRepository
            .getUserIdOrNull()
            .mapValue((e) => e ?? _fallback)
            .mapValue((userId) => firebaseStorage.ref().child('/users/user/$userId/${type.value}/$fileName'))
            .mapValue((ref) async => await ref.putData(await file.readAsBytes()))
            .mapValue((task) => task.ref.getDownloadURL());
      });
}

import 'package:core/core.dart';
import 'package:generated_assets/generated_assets.dart';

extension CountryGenExt on Country {
  AssetGenImage get asset => AssetGenImage(
        'assets/flags/${code.toLowerCase()}.png',
      );
}

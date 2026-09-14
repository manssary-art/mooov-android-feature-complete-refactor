import 'package:generated_assets/assets.gen.dart';

extension CardInfoBrandExt on String {
  AssetGenImage get cardBrandAsset {
    switch (toLowerCase()) {
      case 'alipay':
        return Assets.images.iconCardBrandAlipay;
      case 'amex':
        return Assets.images.iconCardBrandAmex;
      case 'diners':
        return Assets.images.iconCardBrandDiners;
      case 'discover':
        return Assets.images.iconCardBrandDiscover;
      case 'elo':
        return Assets.images.iconCardBrandElo;
      case 'hiper':
        return Assets.images.iconCardBrandHiper;
      case 'hipercard':
        return Assets.images.iconCardBrandHipercard;
      case 'jcb':
        return Assets.images.iconCardBrandJcb;
      case 'maestro':
        return Assets.images.iconCardBrandMaestro;
      case 'mastercard':
        return Assets.images.iconCardBrandMastercard;
      case 'mir':
        return Assets.images.iconCardBrandMir;
      case 'paypal':
        return Assets.images.iconCardBrandPaypal;
      case 'unionpay':
        return Assets.images.iconCardBrandUnionpay;
      case 'visa':
        return Assets.images.iconCardBrandVisa;
      default:
        return Assets.images.iconCard;
    }
  }
}

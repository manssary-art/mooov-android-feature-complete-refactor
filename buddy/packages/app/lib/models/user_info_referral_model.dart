import 'package:equatable/equatable.dart';

class UserInfoReferralModel with EquatableMixin {
  final String? referralCode;
  final String? referralLink;
  final String? referredBy;

  const UserInfoReferralModel({
    required this.referralCode,
    required this.referralLink,
    required this.referredBy,
  });

  @override
  List<Object?> get props => [
        referralCode,
        referralLink,
        referredBy,
      ];

  UserInfoReferralModel copyWith({
    String? Function()? referralCode,
    String? Function()? referralLink,
    String? Function()? referredBy,
  }) {
    return UserInfoReferralModel(
      referralCode: referralCode != null ? referralCode() : this.referralCode,
      referralLink: referralLink != null ? referralLink() : this.referralLink,
      referredBy: referredBy != null ? referredBy() : this.referredBy,
    );
  }
}

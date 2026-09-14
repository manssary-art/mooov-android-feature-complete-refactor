enum UserLevel {
  bronze,
  silver,
  gold,
  platinum,
}

extension DtoStringUserRoleModelExt on String {
  UserLevel toUserLevel() {
    switch (toUpperCase()) {
      case _UserLevelValue.bronze:
        return UserLevel.bronze;
      case _UserLevelValue.silver:
        return UserLevel.silver;
      case _UserLevelValue.gold:
        return UserLevel.gold;
      case _UserLevelValue.platinum:
        return UserLevel.platinum;
      default:
        return UserLevel.bronze;
    }
  }
}

extension UserRoleModelDtoStringExt on UserLevel {
  String toDtoString() {
    switch (this) {
      case UserLevel.bronze:
        return _UserLevelValue.bronze;
      case UserLevel.silver:
        return _UserLevelValue.silver;
      case UserLevel.gold:
        return _UserLevelValue.gold;
      case UserLevel.platinum:
        return _UserLevelValue.platinum;
    }
  }
}

final class _UserLevelValue {
  static const bronze = "BRONZE";
  static const silver = "SILVER";
  static const gold = "GOLD";
  static const platinum = "PLATINUM";
}

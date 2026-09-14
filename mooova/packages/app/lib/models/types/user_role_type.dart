enum UserRole {
  user,
  worker,
}

extension DtoStringUserRoleModelExt on String {
  UserRole toUserRole() {
    switch (this) {
      case _UserRoleValue.worker:
        return UserRole.worker;
      case _UserRoleValue.user:
        return UserRole.user;
      default:
        return UserRole.user;
    }
  }
}

extension UserRoleModelDtoStringExt on UserRole {
  String toDtoString() {
    switch (this) {
      case UserRole.worker:
        return _UserRoleValue.worker;
      case UserRole.user:
        return _UserRoleValue.user;
      default:
        return _UserRoleValue.user;
    }
  }
}

final class _UserRoleValue {
  static const worker = "MOOOVER";
  static const user = "USER";
}

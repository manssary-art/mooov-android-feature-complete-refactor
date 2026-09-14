import 'package:equatable/equatable.dart';

class UserInfoBusinessModel with EquatableMixin {
  final String? name;
  final String? vatNumber;
  final String? address;
  final bool? hasTrafficPermit;

  const UserInfoBusinessModel({
    this.name,
    this.vatNumber,
    this.address,
    this.hasTrafficPermit,
  });

  @override
  List<Object?> get props => [
        name,
        vatNumber,
        address,
        hasTrafficPermit,
      ];

  UserInfoBusinessModel copyWith({
    String? Function()? name,
    String? Function()? vatNumber,
    String? Function()? address,
    bool? Function()? hasTrafficPermit,
  }) {
    return UserInfoBusinessModel(
      name: name != null ? name() : this.name,
      vatNumber: vatNumber != null ? vatNumber() : this.vatNumber,
      address: address != null ? address() : this.address,
      hasTrafficPermit: hasTrafficPermit != null ? hasTrafficPermit() : this.hasTrafficPermit,
    );
  }
}

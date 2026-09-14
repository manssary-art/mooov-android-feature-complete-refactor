import 'package:json_annotation/json_annotation.dart';

import 'user_dto.dart';

part 'order_worker_candidate_dto.g.dart';

@JsonSerializable()
class OrderWorkerCandidate {
  @JsonKey(name: 'pickupTime')
  final List<int> pickupTime;
  @JsonKey(name: 'mooover')
  final UserDto? worker;

  const OrderWorkerCandidate({
    required this.pickupTime,
    required this.worker,
  });

  factory OrderWorkerCandidate.fromJson(Map<String, dynamic> json) => _$OrderWorkerCandidateFromJson(json);

  Map<String, dynamic> toJson() => _$OrderWorkerCandidateToJson(this);
}

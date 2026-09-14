// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_worker_candidate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderWorkerCandidate _$OrderWorkerCandidateFromJson(
        Map<String, dynamic> json) =>
    OrderWorkerCandidate(
      pickupTime:
          (json['pickupTime'] as List<dynamic>).map((e) => e as int).toList(),
      worker: json['mooover'] == null
          ? null
          : UserDto.fromJson(json['mooover'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderWorkerCandidateToJson(
        OrderWorkerCandidate instance) =>
    <String, dynamic>{
      'pickupTime': instance.pickupTime,
      'mooover': instance.worker,
    };

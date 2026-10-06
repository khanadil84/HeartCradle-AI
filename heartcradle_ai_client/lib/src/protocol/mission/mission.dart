/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Mission
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Mission._({
    this.id,
    this.missionId,
    required this.patientId,
    required this.status,
    required this.completedSteps,
    required this.totalSteps,
    required this.currentStep,
    required this.startedAt,
    this.completedAt,
    required this.lastEvent,
  });

  factory Mission({
    int? id,
    String? missionId,
    required String patientId,
    required String status,
    required int completedSteps,
    required int totalSteps,
    required String currentStep,
    required DateTime startedAt,
    DateTime? completedAt,
    required String lastEvent,
  }) = _MissionImpl;

  factory Mission.fromJson(Map<String, dynamic> jsonSerialization) {
    return Mission(
      id: jsonSerialization['id'] as int?,
      missionId: jsonSerialization['missionId'] as String?,
      patientId: jsonSerialization['patientId'] as String,
      status: jsonSerialization['status'] as String,
      completedSteps: jsonSerialization['completedSteps'] as int,
      totalSteps: jsonSerialization['totalSteps'] as int,
      currentStep: jsonSerialization['currentStep'] as String,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      lastEvent: jsonSerialization['lastEvent'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? missionId;

  String patientId;

  String status;

  int completedSteps;

  int totalSteps;

  String currentStep;

  DateTime startedAt;

  DateTime? completedAt;

  String lastEvent;

  /// Returns a shallow copy of this [Mission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Mission copyWith({
    int? id,
    String? missionId,
    String? patientId,
    String? status,
    int? completedSteps,
    int? totalSteps,
    String? currentStep,
    DateTime? startedAt,
    DateTime? completedAt,
    String? lastEvent,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Mission',
      if (id != null) 'id': id,
      if (missionId != null) 'missionId': missionId,
      'patientId': patientId,
      'status': status,
      'completedSteps': completedSteps,
      'totalSteps': totalSteps,
      'currentStep': currentStep,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'lastEvent': lastEvent,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Mission',
      if (id != null) 'id': id,
      if (missionId != null) 'missionId': missionId,
      'patientId': patientId,
      'status': status,
      'completedSteps': completedSteps,
      'totalSteps': totalSteps,
      'currentStep': currentStep,
      'startedAt': startedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      'lastEvent': lastEvent,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MissionImpl extends Mission {
  _MissionImpl({
    int? id,
    String? missionId,
    required String patientId,
    required String status,
    required int completedSteps,
    required int totalSteps,
    required String currentStep,
    required DateTime startedAt,
    DateTime? completedAt,
    required String lastEvent,
  }) : super._(
         id: id,
         missionId: missionId,
         patientId: patientId,
         status: status,
         completedSteps: completedSteps,
         totalSteps: totalSteps,
         currentStep: currentStep,
         startedAt: startedAt,
         completedAt: completedAt,
         lastEvent: lastEvent,
       );

  /// Returns a shallow copy of this [Mission]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Mission copyWith({
    Object? id = _Undefined,
    Object? missionId = _Undefined,
    String? patientId,
    String? status,
    int? completedSteps,
    int? totalSteps,
    String? currentStep,
    DateTime? startedAt,
    Object? completedAt = _Undefined,
    String? lastEvent,
  }) {
    return Mission(
      id: id is int? ? id : this.id,
      missionId: missionId is String? ? missionId : this.missionId,
      patientId: patientId ?? this.patientId,
      status: status ?? this.status,
      completedSteps: completedSteps ?? this.completedSteps,
      totalSteps: totalSteps ?? this.totalSteps,
      currentStep: currentStep ?? this.currentStep,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      lastEvent: lastEvent ?? this.lastEvent,
    );
  }
}

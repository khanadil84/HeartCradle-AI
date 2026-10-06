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

abstract class TriageEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TriageEvent._({
    this.id,
    this.eventId,
    required this.patientId,
    required this.heartRate,
    required this.spo2,
    required this.respiratoryRate,
    required this.temperature,
    required this.signalQuality,
    required this.decision,
    required this.reason,
    required this.createdAt,
  });

  factory TriageEvent({
    int? id,
    String? eventId,
    required String patientId,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
    required String decision,
    required String reason,
    required DateTime createdAt,
  }) = _TriageEventImpl;

  factory TriageEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TriageEvent(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String?,
      patientId: jsonSerialization['patientId'] as String,
      heartRate: jsonSerialization['heartRate'] as int,
      spo2: jsonSerialization['spo2'] as int,
      respiratoryRate: jsonSerialization['respiratoryRate'] as int,
      temperature: (jsonSerialization['temperature'] as num).toDouble(),
      signalQuality: jsonSerialization['signalQuality'] as String,
      decision: jsonSerialization['decision'] as String,
      reason: jsonSerialization['reason'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? eventId;

  String patientId;

  int heartRate;

  int spo2;

  int respiratoryRate;

  double temperature;

  String signalQuality;

  String decision;

  String reason;

  DateTime createdAt;

  /// Returns a shallow copy of this [TriageEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TriageEvent copyWith({
    int? id,
    String? eventId,
    String? patientId,
    int? heartRate,
    int? spo2,
    int? respiratoryRate,
    double? temperature,
    String? signalQuality,
    String? decision,
    String? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TriageEvent',
      if (id != null) 'id': id,
      if (eventId != null) 'eventId': eventId,
      'patientId': patientId,
      'heartRate': heartRate,
      'spo2': spo2,
      'respiratoryRate': respiratoryRate,
      'temperature': temperature,
      'signalQuality': signalQuality,
      'decision': decision,
      'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TriageEvent',
      if (id != null) 'id': id,
      if (eventId != null) 'eventId': eventId,
      'patientId': patientId,
      'heartRate': heartRate,
      'spo2': spo2,
      'respiratoryRate': respiratoryRate,
      'temperature': temperature,
      'signalQuality': signalQuality,
      'decision': decision,
      'reason': reason,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TriageEventImpl extends TriageEvent {
  _TriageEventImpl({
    int? id,
    String? eventId,
    required String patientId,
    required int heartRate,
    required int spo2,
    required int respiratoryRate,
    required double temperature,
    required String signalQuality,
    required String decision,
    required String reason,
    required DateTime createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         patientId: patientId,
         heartRate: heartRate,
         spo2: spo2,
         respiratoryRate: respiratoryRate,
         temperature: temperature,
         signalQuality: signalQuality,
         decision: decision,
         reason: reason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [TriageEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TriageEvent copyWith({
    Object? id = _Undefined,
    Object? eventId = _Undefined,
    String? patientId,
    int? heartRate,
    int? spo2,
    int? respiratoryRate,
    double? temperature,
    String? signalQuality,
    String? decision,
    String? reason,
    DateTime? createdAt,
  }) {
    return TriageEvent(
      id: id is int? ? id : this.id,
      eventId: eventId is String? ? eventId : this.eventId,
      patientId: patientId ?? this.patientId,
      heartRate: heartRate ?? this.heartRate,
      spo2: spo2 ?? this.spo2,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      temperature: temperature ?? this.temperature,
      signalQuality: signalQuality ?? this.signalQuality,
      decision: decision ?? this.decision,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

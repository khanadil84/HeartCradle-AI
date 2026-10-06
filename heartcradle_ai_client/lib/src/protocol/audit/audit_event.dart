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

abstract class AuditEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AuditEvent._({
    this.id,
    this.eventId,
    required this.missionId,
    required this.event,
    required this.fromState,
    required this.toState,
    required this.createdAt,
  });

  factory AuditEvent({
    int? id,
    String? eventId,
    required String missionId,
    required String event,
    required String fromState,
    required String toState,
    required DateTime createdAt,
  }) = _AuditEventImpl;

  factory AuditEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditEvent(
      id: jsonSerialization['id'] as int?,
      eventId: jsonSerialization['eventId'] as String?,
      missionId: jsonSerialization['missionId'] as String,
      event: jsonSerialization['event'] as String,
      fromState: jsonSerialization['fromState'] as String,
      toState: jsonSerialization['toState'] as String,
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

  String missionId;

  String event;

  String fromState;

  String toState;

  DateTime createdAt;

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AuditEvent copyWith({
    int? id,
    String? eventId,
    String? missionId,
    String? event,
    String? fromState,
    String? toState,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditEvent',
      if (id != null) 'id': id,
      if (eventId != null) 'eventId': eventId,
      'missionId': missionId,
      'event': event,
      'fromState': fromState,
      'toState': toState,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuditEvent',
      if (id != null) 'id': id,
      if (eventId != null) 'eventId': eventId,
      'missionId': missionId,
      'event': event,
      'fromState': fromState,
      'toState': toState,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditEventImpl extends AuditEvent {
  _AuditEventImpl({
    int? id,
    String? eventId,
    required String missionId,
    required String event,
    required String fromState,
    required String toState,
    required DateTime createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         missionId: missionId,
         event: event,
         fromState: fromState,
         toState: toState,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AuditEvent copyWith({
    Object? id = _Undefined,
    Object? eventId = _Undefined,
    String? missionId,
    String? event,
    String? fromState,
    String? toState,
    DateTime? createdAt,
  }) {
    return AuditEvent(
      id: id is int? ? id : this.id,
      eventId: eventId is String? ? eventId : this.eventId,
      missionId: missionId ?? this.missionId,
      event: event ?? this.event,
      fromState: fromState ?? this.fromState,
      toState: toState ?? this.toState,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

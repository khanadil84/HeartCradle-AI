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
import 'package:serverpod/serverpod.dart' as _is;

abstract class TriageEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = TriageEventTable();

  static const db = TriageEventRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TriageEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static TriageEventInclude include() {
    return TriageEventInclude._();
  }

  static TriageEventIncludeList includeList({
    _is.WhereExpressionBuilder<TriageEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    TriageEventInclude? include,
  }) {
    return TriageEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class TriageEventUpdateTable extends _is.UpdateTable<TriageEventTable> {
  TriageEventUpdateTable(super.table);

  _is.ColumnValue<String, String> eventId(String? value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> patientId(String value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<int, int> heartRate(int value) => _is.ColumnValue(
    table.heartRate,
    value,
  );

  _is.ColumnValue<int, int> spo2(int value) => _is.ColumnValue(
    table.spo2,
    value,
  );

  _is.ColumnValue<int, int> respiratoryRate(int value) => _is.ColumnValue(
    table.respiratoryRate,
    value,
  );

  _is.ColumnValue<double, double> temperature(double value) => _is.ColumnValue(
    table.temperature,
    value,
  );

  _is.ColumnValue<String, String> signalQuality(String value) =>
      _is.ColumnValue(
        table.signalQuality,
        value,
      );

  _is.ColumnValue<String, String> decision(String value) => _is.ColumnValue(
    table.decision,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class TriageEventTable extends _is.Table<int?> {
  TriageEventTable({super.tableRelation}) : super(tableName: 'triage_event') {
    updateTable = TriageEventUpdateTable(this);
    eventId = _is.ColumnString(
      'eventId',
      this,
    );
    patientId = _is.ColumnString(
      'patientId',
      this,
    );
    heartRate = _is.ColumnInt(
      'heartRate',
      this,
    );
    spo2 = _is.ColumnInt(
      'spo2',
      this,
    );
    respiratoryRate = _is.ColumnInt(
      'respiratoryRate',
      this,
    );
    temperature = _is.ColumnDouble(
      'temperature',
      this,
    );
    signalQuality = _is.ColumnString(
      'signalQuality',
      this,
    );
    decision = _is.ColumnString(
      'decision',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final TriageEventUpdateTable updateTable;

  late final _is.ColumnString eventId;

  late final _is.ColumnString patientId;

  late final _is.ColumnInt heartRate;

  late final _is.ColumnInt spo2;

  late final _is.ColumnInt respiratoryRate;

  late final _is.ColumnDouble temperature;

  late final _is.ColumnString signalQuality;

  late final _is.ColumnString decision;

  late final _is.ColumnString reason;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    patientId,
    heartRate,
    spo2,
    respiratoryRate,
    temperature,
    signalQuality,
    decision,
    reason,
    createdAt,
  ];
}

class TriageEventInclude extends _is.IncludeObject {
  TriageEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TriageEvent.t;
}

class TriageEventIncludeList extends _is.IncludeList {
  TriageEventIncludeList._({
    _is.WhereExpressionBuilder<TriageEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TriageEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TriageEvent.t;
}

class TriageEventRepository {
  const TriageEventRepository._();

  /// Returns a list of [TriageEvent]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TriageEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TriageEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TriageEvent>(
      where: where?.call(TriageEvent.t),
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TriageEvent] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TriageEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TriageEventTable>? where,
    int? offset,
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TriageEvent>(
      where: where?.call(TriageEvent.t),
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TriageEvent] by its [id] or null if no such row exists.
  Future<TriageEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TriageEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TriageEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [TriageEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> insert(
    _is.DatabaseSession session,
    List<TriageEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TriageEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TriageEvent] and returns the inserted row.
  ///
  /// The returned [TriageEvent] will have its `id` field set.
  Future<TriageEvent> insertRow(
    _is.DatabaseSession session,
    TriageEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TriageEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TriageEvent]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [TriageEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> upsert(
    _is.DatabaseSession session,
    List<TriageEvent> rows, {
    required _is.ColumnSelections<TriageEventTable> conflictColumns,
    _is.ColumnSelections<TriageEventTable>? updateColumns,
    _is.WhereExpressionBuilder<TriageEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TriageEvent>(
      rows,
      conflictColumns: conflictColumns(TriageEvent.t),
      updateColumns: updateColumns?.call(TriageEvent.t),
      updateWhere: updateWhere?.call(TriageEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TriageEvent] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [TriageEvent] will have its `id` field set.
  Future<TriageEvent?> upsertRow(
    _is.DatabaseSession session,
    TriageEvent row, {
    required _is.ColumnSelections<TriageEventTable> conflictColumns,
    _is.ColumnSelections<TriageEventTable>? updateColumns,
    _is.WhereExpressionBuilder<TriageEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TriageEvent>(
      row,
      conflictColumns: conflictColumns(TriageEvent.t),
      updateColumns: updateColumns?.call(TriageEvent.t),
      updateWhere: updateWhere?.call(TriageEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [TriageEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> update(
    _is.DatabaseSession session,
    List<TriageEvent> rows, {
    _is.ColumnSelections<TriageEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TriageEvent>(
      rows,
      columns: columns?.call(TriageEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TriageEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TriageEvent> updateRow(
    _is.DatabaseSession session,
    TriageEvent row, {
    _is.ColumnSelections<TriageEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TriageEvent>(
      row,
      columns: columns?.call(TriageEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TriageEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TriageEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TriageEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TriageEvent>(
      id,
      columnValues: columnValues(TriageEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TriageEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TriageEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TriageEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TriageEvent>(
      columnValues: columnValues(TriageEvent.t.updateTable),
      where: where(TriageEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TriageEvent]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> delete(
    _is.DatabaseSession session,
    List<TriageEvent> rows, {
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TriageEvent>(
      rows,
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TriageEvent].
  Future<TriageEvent> deleteRow(
    _is.DatabaseSession session,
    TriageEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TriageEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TriageEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TriageEventTable> where,
    _is.OrderByBuilder<TriageEventTable>? orderBy,
    _is.OrderByListBuilder<TriageEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TriageEvent>(
      where: where(TriageEvent.t),
      orderBy: orderBy?.call(TriageEvent.t),
      orderByList: orderByList?.call(TriageEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TriageEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TriageEvent>(
      where: where?.call(TriageEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TriageEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TriageEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TriageEvent>(
      where: where(TriageEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

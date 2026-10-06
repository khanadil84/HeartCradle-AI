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

abstract class AuditEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AuditEventTable();

  static const db = AuditEventRepository._();

  @override
  int? id;

  String? eventId;

  String missionId;

  String event;

  String fromState;

  String toState;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static AuditEventInclude include() {
    return AuditEventInclude._();
  }

  static AuditEventIncludeList includeList({
    _is.WhereExpressionBuilder<AuditEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    AuditEventInclude? include,
  }) {
    return AuditEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class AuditEventUpdateTable extends _is.UpdateTable<AuditEventTable> {
  AuditEventUpdateTable(super.table);

  _is.ColumnValue<String, String> eventId(String? value) => _is.ColumnValue(
    table.eventId,
    value,
  );

  _is.ColumnValue<String, String> missionId(String value) => _is.ColumnValue(
    table.missionId,
    value,
  );

  _is.ColumnValue<String, String> event(String value) => _is.ColumnValue(
    table.event,
    value,
  );

  _is.ColumnValue<String, String> fromState(String value) => _is.ColumnValue(
    table.fromState,
    value,
  );

  _is.ColumnValue<String, String> toState(String value) => _is.ColumnValue(
    table.toState,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class AuditEventTable extends _is.Table<int?> {
  AuditEventTable({super.tableRelation}) : super(tableName: 'audit_event') {
    updateTable = AuditEventUpdateTable(this);
    eventId = _is.ColumnString(
      'eventId',
      this,
    );
    missionId = _is.ColumnString(
      'missionId',
      this,
    );
    event = _is.ColumnString(
      'event',
      this,
    );
    fromState = _is.ColumnString(
      'fromState',
      this,
    );
    toState = _is.ColumnString(
      'toState',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final AuditEventUpdateTable updateTable;

  late final _is.ColumnString eventId;

  late final _is.ColumnString missionId;

  late final _is.ColumnString event;

  late final _is.ColumnString fromState;

  late final _is.ColumnString toState;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    eventId,
    missionId,
    event,
    fromState,
    toState,
    createdAt,
  ];
}

class AuditEventInclude extends _is.IncludeObject {
  AuditEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AuditEvent.t;
}

class AuditEventIncludeList extends _is.IncludeList {
  AuditEventIncludeList._({
    _is.WhereExpressionBuilder<AuditEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AuditEvent.t;
}

class AuditEventRepository {
  const AuditEventRepository._();

  /// Returns a list of [AuditEvent]s matching the given query parameters.
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
  Future<List<AuditEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditEvent>(
      where: where?.call(AuditEvent.t),
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditEvent] matching the given query parameters.
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
  Future<AuditEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditEventTable>? where,
    int? offset,
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditEvent>(
      where: where?.call(AuditEvent.t),
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditEvent] by its [id] or null if no such row exists.
  Future<AuditEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditEvent]s will have their `id` fields set.
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
  Future<List<AuditEvent>> insert(
    _is.DatabaseSession session,
    List<AuditEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AuditEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AuditEvent] and returns the inserted row.
  ///
  /// The returned [AuditEvent] will have its `id` field set.
  Future<AuditEvent> insertRow(
    _is.DatabaseSession session,
    AuditEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AuditEvent]s in the list and returns the resulting rows.
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
  /// The returned [AuditEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEvent>> upsert(
    _is.DatabaseSession session,
    List<AuditEvent> rows, {
    required _is.ColumnSelections<AuditEventTable> conflictColumns,
    _is.ColumnSelections<AuditEventTable>? updateColumns,
    _is.WhereExpressionBuilder<AuditEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AuditEvent>(
      rows,
      conflictColumns: conflictColumns(AuditEvent.t),
      updateColumns: updateColumns?.call(AuditEvent.t),
      updateWhere: updateWhere?.call(AuditEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AuditEvent] and returns the resulting row.
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
  /// The returned [AuditEvent] will have its `id` field set.
  Future<AuditEvent?> upsertRow(
    _is.DatabaseSession session,
    AuditEvent row, {
    required _is.ColumnSelections<AuditEventTable> conflictColumns,
    _is.ColumnSelections<AuditEventTable>? updateColumns,
    _is.WhereExpressionBuilder<AuditEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AuditEvent>(
      row,
      conflictColumns: conflictColumns(AuditEvent.t),
      updateColumns: updateColumns?.call(AuditEvent.t),
      updateWhere: updateWhere?.call(AuditEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [AuditEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEvent>> update(
    _is.DatabaseSession session,
    List<AuditEvent> rows, {
    _is.ColumnSelections<AuditEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AuditEvent>(
      rows,
      columns: columns?.call(AuditEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AuditEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditEvent> updateRow(
    _is.DatabaseSession session,
    AuditEvent row, {
    _is.ColumnSelections<AuditEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditEvent>(
      row,
      columns: columns?.call(AuditEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AuditEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditEvent>(
      id,
      columnValues: columnValues(AuditEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AuditEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AuditEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AuditEvent>(
      columnValues: columnValues(AuditEvent.t.updateTable),
      where: where(AuditEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AuditEvent]s in the list and returns the deleted rows.
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
  Future<List<AuditEvent>> delete(
    _is.DatabaseSession session,
    List<AuditEvent> rows, {
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AuditEvent>(
      rows,
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AuditEvent].
  Future<AuditEvent> deleteRow(
    _is.DatabaseSession session,
    AuditEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditEvent>(
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
  Future<List<AuditEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AuditEventTable> where,
    _is.OrderByBuilder<AuditEventTable>? orderBy,
    _is.OrderByListBuilder<AuditEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AuditEvent>(
      where: where(AuditEvent.t),
      orderBy: orderBy?.call(AuditEvent.t),
      orderByList: orderByList?.call(AuditEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AuditEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AuditEvent>(
      where: where?.call(AuditEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AuditEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditEvent>(
      where: where(AuditEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

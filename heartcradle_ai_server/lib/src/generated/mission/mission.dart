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

abstract class Mission
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      lastEvent: jsonSerialization['lastEvent'] as String,
    );
  }

  static final t = MissionTable();

  static const db = MissionRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Mission]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static MissionInclude include() {
    return MissionInclude._();
  }

  static MissionIncludeList includeList({
    _is.WhereExpressionBuilder<MissionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    MissionInclude? include,
  }) {
    return MissionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class MissionUpdateTable extends _is.UpdateTable<MissionTable> {
  MissionUpdateTable(super.table);

  _is.ColumnValue<String, String> missionId(String? value) => _is.ColumnValue(
    table.missionId,
    value,
  );

  _is.ColumnValue<String, String> patientId(String value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> completedSteps(int value) => _is.ColumnValue(
    table.completedSteps,
    value,
  );

  _is.ColumnValue<int, int> totalSteps(int value) => _is.ColumnValue(
    table.totalSteps,
    value,
  );

  _is.ColumnValue<String, String> currentStep(String value) => _is.ColumnValue(
    table.currentStep,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<String, String> lastEvent(String value) => _is.ColumnValue(
    table.lastEvent,
    value,
  );
}

class MissionTable extends _is.Table<int?> {
  MissionTable({super.tableRelation}) : super(tableName: 'mission') {
    updateTable = MissionUpdateTable(this);
    missionId = _is.ColumnString(
      'missionId',
      this,
    );
    patientId = _is.ColumnString(
      'patientId',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    completedSteps = _is.ColumnInt(
      'completedSteps',
      this,
    );
    totalSteps = _is.ColumnInt(
      'totalSteps',
      this,
    );
    currentStep = _is.ColumnString(
      'currentStep',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    lastEvent = _is.ColumnString(
      'lastEvent',
      this,
    );
  }

  late final MissionUpdateTable updateTable;

  late final _is.ColumnString missionId;

  late final _is.ColumnString patientId;

  late final _is.ColumnString status;

  late final _is.ColumnInt completedSteps;

  late final _is.ColumnInt totalSteps;

  late final _is.ColumnString currentStep;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnString lastEvent;

  @override
  List<_is.Column> get columns => [
    id,
    missionId,
    patientId,
    status,
    completedSteps,
    totalSteps,
    currentStep,
    startedAt,
    completedAt,
    lastEvent,
  ];
}

class MissionInclude extends _is.IncludeObject {
  MissionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Mission.t;
}

class MissionIncludeList extends _is.IncludeList {
  MissionIncludeList._({
    _is.WhereExpressionBuilder<MissionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Mission.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Mission.t;
}

class MissionRepository {
  const MissionRepository._();

  /// Returns a list of [Mission]s matching the given query parameters.
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
  Future<List<Mission>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MissionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Mission>(
      where: where?.call(Mission.t),
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Mission] matching the given query parameters.
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
  Future<Mission?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MissionTable>? where,
    int? offset,
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Mission>(
      where: where?.call(Mission.t),
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Mission] by its [id] or null if no such row exists.
  Future<Mission?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Mission>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Mission]s in the list and returns the inserted rows.
  ///
  /// The returned [Mission]s will have their `id` fields set.
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
  Future<List<Mission>> insert(
    _is.DatabaseSession session,
    List<Mission> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Mission>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Mission] and returns the inserted row.
  ///
  /// The returned [Mission] will have its `id` field set.
  Future<Mission> insertRow(
    _is.DatabaseSession session,
    Mission row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Mission>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Mission]s in the list and returns the resulting rows.
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
  /// The returned [Mission]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mission>> upsert(
    _is.DatabaseSession session,
    List<Mission> rows, {
    required _is.ColumnSelections<MissionTable> conflictColumns,
    _is.ColumnSelections<MissionTable>? updateColumns,
    _is.WhereExpressionBuilder<MissionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Mission>(
      rows,
      conflictColumns: conflictColumns(Mission.t),
      updateColumns: updateColumns?.call(Mission.t),
      updateWhere: updateWhere?.call(Mission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Mission] and returns the resulting row.
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
  /// The returned [Mission] will have its `id` field set.
  Future<Mission?> upsertRow(
    _is.DatabaseSession session,
    Mission row, {
    required _is.ColumnSelections<MissionTable> conflictColumns,
    _is.ColumnSelections<MissionTable>? updateColumns,
    _is.WhereExpressionBuilder<MissionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Mission>(
      row,
      conflictColumns: conflictColumns(Mission.t),
      updateColumns: updateColumns?.call(Mission.t),
      updateWhere: updateWhere?.call(Mission.t),
      transaction: transaction,
    );
  }

  /// Updates all [Mission]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mission>> update(
    _is.DatabaseSession session,
    List<Mission> rows, {
    _is.ColumnSelections<MissionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Mission>(
      rows,
      columns: columns?.call(Mission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Mission]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Mission> updateRow(
    _is.DatabaseSession session,
    Mission row, {
    _is.ColumnSelections<MissionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Mission>(
      row,
      columns: columns?.call(Mission.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Mission] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Mission?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<MissionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Mission>(
      id,
      columnValues: columnValues(Mission.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Mission]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Mission>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<MissionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<MissionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Mission>(
      columnValues: columnValues(Mission.t.updateTable),
      where: where(Mission.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Mission]s in the list and returns the deleted rows.
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
  Future<List<Mission>> delete(
    _is.DatabaseSession session,
    List<Mission> rows, {
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Mission>(
      rows,
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Mission].
  Future<Mission> deleteRow(
    _is.DatabaseSession session,
    Mission row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Mission>(
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
  Future<List<Mission>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MissionTable> where,
    _is.OrderByBuilder<MissionTable>? orderBy,
    _is.OrderByListBuilder<MissionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Mission>(
      where: where(Mission.t),
      orderBy: orderBy?.call(Mission.t),
      orderByList: orderByList?.call(Mission.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<MissionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Mission>(
      where: where?.call(Mission.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Mission] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<MissionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Mission>(
      where: where(Mission.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

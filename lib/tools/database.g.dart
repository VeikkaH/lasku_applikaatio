// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProjectDataTable extends ProjectData
    with TableInfo<$ProjectDataTable, ProjectDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _projectNameMeta =
      const VerificationMeta('projectName');
  @override
  late final GeneratedColumn<String> projectName = GeneratedColumn<String>(
      'Name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, projectName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'project_data';
  @override
  VerificationContext validateIntegrity(Insertable<ProjectDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('Name')) {
      context.handle(_projectNameMeta,
          projectName.isAcceptableOrUnknown(data['Name']!, _projectNameMeta));
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProjectDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProjectDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}Name'])!,
    );
  }

  @override
  $ProjectDataTable createAlias(String alias) {
    return $ProjectDataTable(attachedDatabase, alias);
  }
}

class ProjectDataData extends DataClass implements Insertable<ProjectDataData> {
  final int id;
  final String projectName;
  const ProjectDataData({required this.id, required this.projectName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['Name'] = Variable<String>(projectName);
    return map;
  }

  ProjectDataCompanion toCompanion(bool nullToAbsent) {
    return ProjectDataCompanion(
      id: Value(id),
      projectName: Value(projectName),
    );
  }

  factory ProjectDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProjectDataData(
      id: serializer.fromJson<int>(json['id']),
      projectName: serializer.fromJson<String>(json['projectName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectName': serializer.toJson<String>(projectName),
    };
  }

  ProjectDataData copyWith({int? id, String? projectName}) => ProjectDataData(
        id: id ?? this.id,
        projectName: projectName ?? this.projectName,
      );
  ProjectDataData copyWithCompanion(ProjectDataCompanion data) {
    return ProjectDataData(
      id: data.id.present ? data.id.value : this.id,
      projectName:
          data.projectName.present ? data.projectName.value : this.projectName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProjectDataData(')
          ..write('id: $id, ')
          ..write('projectName: $projectName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, projectName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProjectDataData &&
          other.id == this.id &&
          other.projectName == this.projectName);
}

class ProjectDataCompanion extends UpdateCompanion<ProjectDataData> {
  final Value<int> id;
  final Value<String> projectName;
  const ProjectDataCompanion({
    this.id = const Value.absent(),
    this.projectName = const Value.absent(),
  });
  ProjectDataCompanion.insert({
    this.id = const Value.absent(),
    required String projectName,
  }) : projectName = Value(projectName);
  static Insertable<ProjectDataData> custom({
    Expression<int>? id,
    Expression<String>? projectName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectName != null) 'Name': projectName,
    });
  }

  ProjectDataCompanion copyWith({Value<int>? id, Value<String>? projectName}) {
    return ProjectDataCompanion(
      id: id ?? this.id,
      projectName: projectName ?? this.projectName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectName.present) {
      map['Name'] = Variable<String>(projectName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectDataCompanion(')
          ..write('id: $id, ')
          ..write('projectName: $projectName')
          ..write(')'))
        .toString();
  }
}

class $PartDataTable extends PartData
    with TableInfo<$PartDataTable, PartDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _projectIdMeta =
      const VerificationMeta('projectId');
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
      'project_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints:
          'REFERENCES project_data(id) ON DELETE CASCADE NOT NULL');
  static const VerificationMeta _partNameMeta =
      const VerificationMeta('partName');
  @override
  late final GeneratedColumn<String> partName = GeneratedColumn<String>(
      'part_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<double> length = GeneratedColumn<double>(
      'length', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
      'width', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<double> depth = GeneratedColumn<double>(
      'depth', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, projectId, partName, length, width, depth];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'part_data';
  @override
  VerificationContext validateIntegrity(Insertable<PartDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(_projectIdMeta,
          projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta));
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('part_name')) {
      context.handle(_partNameMeta,
          partName.isAcceptableOrUnknown(data['part_name']!, _partNameMeta));
    } else if (isInserting) {
      context.missing(_partNameMeta);
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    } else if (isInserting) {
      context.missing(_lengthMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PartDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      projectId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_id'])!,
      partName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}part_name'])!,
      length: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}length'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}width'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}depth'])!,
    );
  }

  @override
  $PartDataTable createAlias(String alias) {
    return $PartDataTable(attachedDatabase, alias);
  }
}

class PartDataData extends DataClass implements Insertable<PartDataData> {
  final int id;
  final int projectId;
  final String partName;
  final double length;
  final double width;
  final double depth;
  const PartDataData(
      {required this.id,
      required this.projectId,
      required this.partName,
      required this.length,
      required this.width,
      required this.depth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['part_name'] = Variable<String>(partName);
    map['length'] = Variable<double>(length);
    map['width'] = Variable<double>(width);
    map['depth'] = Variable<double>(depth);
    return map;
  }

  PartDataCompanion toCompanion(bool nullToAbsent) {
    return PartDataCompanion(
      id: Value(id),
      projectId: Value(projectId),
      partName: Value(partName),
      length: Value(length),
      width: Value(width),
      depth: Value(depth),
    );
  }

  factory PartDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartDataData(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      partName: serializer.fromJson<String>(json['partName']),
      length: serializer.fromJson<double>(json['length']),
      width: serializer.fromJson<double>(json['width']),
      depth: serializer.fromJson<double>(json['depth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'partName': serializer.toJson<String>(partName),
      'length': serializer.toJson<double>(length),
      'width': serializer.toJson<double>(width),
      'depth': serializer.toJson<double>(depth),
    };
  }

  PartDataData copyWith(
          {int? id,
          int? projectId,
          String? partName,
          double? length,
          double? width,
          double? depth}) =>
      PartDataData(
        id: id ?? this.id,
        projectId: projectId ?? this.projectId,
        partName: partName ?? this.partName,
        length: length ?? this.length,
        width: width ?? this.width,
        depth: depth ?? this.depth,
      );
  PartDataData copyWithCompanion(PartDataCompanion data) {
    return PartDataData(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      partName: data.partName.present ? data.partName.value : this.partName,
      length: data.length.present ? data.length.value : this.length,
      width: data.width.present ? data.width.value : this.width,
      depth: data.depth.present ? data.depth.value : this.depth,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartDataData(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('partName: $partName, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, projectId, partName, length, width, depth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartDataData &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.partName == this.partName &&
          other.length == this.length &&
          other.width == this.width &&
          other.depth == this.depth);
}

class PartDataCompanion extends UpdateCompanion<PartDataData> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<String> partName;
  final Value<double> length;
  final Value<double> width;
  final Value<double> depth;
  const PartDataCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.partName = const Value.absent(),
    this.length = const Value.absent(),
    this.width = const Value.absent(),
    this.depth = const Value.absent(),
  });
  PartDataCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required String partName,
    required double length,
    required double width,
    required double depth,
  })  : projectId = Value(projectId),
        partName = Value(partName),
        length = Value(length),
        width = Value(width),
        depth = Value(depth);
  static Insertable<PartDataData> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<String>? partName,
    Expression<double>? length,
    Expression<double>? width,
    Expression<double>? depth,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (partName != null) 'part_name': partName,
      if (length != null) 'length': length,
      if (width != null) 'width': width,
      if (depth != null) 'depth': depth,
    });
  }

  PartDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? projectId,
      Value<String>? partName,
      Value<double>? length,
      Value<double>? width,
      Value<double>? depth}) {
    return PartDataCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      partName: partName ?? this.partName,
      length: length ?? this.length,
      width: width ?? this.width,
      depth: depth ?? this.depth,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (partName.present) {
      map['part_name'] = Variable<String>(partName.value);
    }
    if (length.present) {
      map['length'] = Variable<double>(length.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (depth.present) {
      map['depth'] = Variable<double>(depth.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartDataCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('partName: $partName, ')
          ..write('length: $length, ')
          ..write('width: $width, ')
          ..write('depth: $depth')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectDataTable projectData = $ProjectDataTable(this);
  late final $PartDataTable partData = $PartDataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [projectData, partData];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('project_data',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('part_data', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ProjectDataTableCreateCompanionBuilder = ProjectDataCompanion
    Function({
  Value<int> id,
  required String projectName,
});
typedef $$ProjectDataTableUpdateCompanionBuilder = ProjectDataCompanion
    Function({
  Value<int> id,
  Value<String> projectName,
});

final class $$ProjectDataTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectDataTable, ProjectDataData> {
  $$ProjectDataTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PartDataTable, List<PartDataData>>
      _partDataRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.partData,
          aliasName:
              $_aliasNameGenerator(db.projectData.id, db.partData.projectId));

  $$PartDataTableProcessedTableManager get partDataRefs {
    final manager = $$PartDataTableTableManager($_db, $_db.partData)
        .filter((f) => f.projectId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_partDataRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProjectDataTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ProjectDataTable> {
  $$ProjectDataTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get projectName => $state.composableBuilder(
      column: $state.table.projectName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter partDataRefs(
      ComposableFilter Function($$PartDataTableFilterComposer f) f) {
    final $$PartDataTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.partData,
        getReferencedColumn: (t) => t.projectId,
        builder: (joinBuilder, parentComposers) =>
            $$PartDataTableFilterComposer(ComposerState(
                $state.db, $state.db.partData, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ProjectDataTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ProjectDataTable> {
  $$ProjectDataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get projectName => $state.composableBuilder(
      column: $state.table.projectName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$ProjectDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProjectDataTable,
    ProjectDataData,
    $$ProjectDataTableFilterComposer,
    $$ProjectDataTableOrderingComposer,
    $$ProjectDataTableCreateCompanionBuilder,
    $$ProjectDataTableUpdateCompanionBuilder,
    (ProjectDataData, $$ProjectDataTableReferences),
    ProjectDataData,
    PrefetchHooks Function({bool partDataRefs})> {
  $$ProjectDataTableTableManager(_$AppDatabase db, $ProjectDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ProjectDataTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ProjectDataTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> projectName = const Value.absent(),
          }) =>
              ProjectDataCompanion(
            id: id,
            projectName: projectName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String projectName,
          }) =>
              ProjectDataCompanion.insert(
            id: id,
            projectName: projectName,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProjectDataTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({partDataRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (partDataRefs) db.partData],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partDataRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ProjectDataTableReferences._partDataRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectDataTableReferences(db, table, p0)
                                .partDataRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProjectDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProjectDataTable,
    ProjectDataData,
    $$ProjectDataTableFilterComposer,
    $$ProjectDataTableOrderingComposer,
    $$ProjectDataTableCreateCompanionBuilder,
    $$ProjectDataTableUpdateCompanionBuilder,
    (ProjectDataData, $$ProjectDataTableReferences),
    ProjectDataData,
    PrefetchHooks Function({bool partDataRefs})>;
typedef $$PartDataTableCreateCompanionBuilder = PartDataCompanion Function({
  Value<int> id,
  required int projectId,
  required String partName,
  required double length,
  required double width,
  required double depth,
});
typedef $$PartDataTableUpdateCompanionBuilder = PartDataCompanion Function({
  Value<int> id,
  Value<int> projectId,
  Value<String> partName,
  Value<double> length,
  Value<double> width,
  Value<double> depth,
});

final class $$PartDataTableReferences
    extends BaseReferences<_$AppDatabase, $PartDataTable, PartDataData> {
  $$PartDataTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectDataTable _projectIdTable(_$AppDatabase db) =>
      db.projectData.createAlias(
          $_aliasNameGenerator(db.partData.projectId, db.projectData.id));

  $$ProjectDataTableProcessedTableManager? get projectId {
    if ($_item.projectId == null) return null;
    final manager = $$ProjectDataTableTableManager($_db, $_db.projectData)
        .filter((f) => f.id($_item.projectId!));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PartDataTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PartDataTable> {
  $$PartDataTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get partName => $state.composableBuilder(
      column: $state.table.partName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get length => $state.composableBuilder(
      column: $state.table.length,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get depth => $state.composableBuilder(
      column: $state.table.depth,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ProjectDataTableFilterComposer get projectId {
    final $$ProjectDataTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $state.db.projectData,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProjectDataTableFilterComposer(ComposerState($state.db,
                $state.db.projectData, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PartDataTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PartDataTable> {
  $$PartDataTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get partName => $state.composableBuilder(
      column: $state.table.partName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get length => $state.composableBuilder(
      column: $state.table.length,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get width => $state.composableBuilder(
      column: $state.table.width,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get depth => $state.composableBuilder(
      column: $state.table.depth,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ProjectDataTableOrderingComposer get projectId {
    final $$ProjectDataTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectId,
        referencedTable: $state.db.projectData,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ProjectDataTableOrderingComposer(ComposerState($state.db,
                $state.db.projectData, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PartDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PartDataTable,
    PartDataData,
    $$PartDataTableFilterComposer,
    $$PartDataTableOrderingComposer,
    $$PartDataTableCreateCompanionBuilder,
    $$PartDataTableUpdateCompanionBuilder,
    (PartDataData, $$PartDataTableReferences),
    PartDataData,
    PrefetchHooks Function({bool projectId})> {
  $$PartDataTableTableManager(_$AppDatabase db, $PartDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PartDataTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PartDataTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> projectId = const Value.absent(),
            Value<String> partName = const Value.absent(),
            Value<double> length = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> depth = const Value.absent(),
          }) =>
              PartDataCompanion(
            id: id,
            projectId: projectId,
            partName: partName,
            length: length,
            width: width,
            depth: depth,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int projectId,
            required String partName,
            required double length,
            required double width,
            required double depth,
          }) =>
              PartDataCompanion.insert(
            id: id,
            projectId: projectId,
            partName: partName,
            length: length,
            width: width,
            depth: depth,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PartDataTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (projectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectId,
                    referencedTable:
                        $$PartDataTableReferences._projectIdTable(db),
                    referencedColumn:
                        $$PartDataTableReferences._projectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PartDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PartDataTable,
    PartDataData,
    $$PartDataTableFilterComposer,
    $$PartDataTableOrderingComposer,
    $$PartDataTableCreateCompanionBuilder,
    $$PartDataTableUpdateCompanionBuilder,
    (PartDataData, $$PartDataTableReferences),
    PartDataData,
    PrefetchHooks Function({bool projectId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectDataTableTableManager get projectData =>
      $$ProjectDataTableTableManager(_db, _db.projectData);
  $$PartDataTableTableManager get partData =>
      $$PartDataTableTableManager(_db, _db.partData);
}

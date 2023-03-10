// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `body` TEXT, `category` INTEGER NOT NULL, `color` INTEGER NOT NULL, `image` BLOB, `alarm` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'category': item.category.index,
                  'color': item.color.index,
                  'image': _imageConverter.encode(item.image),
                  'alarm': _alarmConverter.encode(item.alarm)
                },
            changeListener),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'category': item.category.index,
                  'color': item.color.index,
                  'image': _imageConverter.encode(item.image),
                  'alarm': _alarmConverter.encode(item.alarm)
                },
            changeListener),
        _noteDeletionAdapter = DeletionAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body,
                  'category': item.category.index,
                  'color': item.color.index,
                  'image': _imageConverter.encode(item.image),
                  'alarm': _alarmConverter.encode(item.alarm)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  final DeletionAdapter<Note> _noteDeletionAdapter;

  @override
  Stream<List<Note>> getNotes() {
    return _queryAdapter.queryListStream('SELECT * FROM Note',
        mapper: (Map<String, Object?> row) => Note(
            row['id'] as int?,
            row['title'] as String,
            NoteCategory.values[row['category'] as int],
            row['body'] as String?,
            NoteColor.values[row['color'] as int],
            _imageConverter.decode(row['image'] as Uint8List?),
            _alarmConverter.decode(row['alarm'] as String?)),
        queryableName: 'Note',
        isView: false);
  }

  @override
  Stream<List<Note>> getNotesByCategory(int categoryIndex) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Note WHERE category = ?1',
        mapper: (Map<String, Object?> row) => Note(
            row['id'] as int?,
            row['title'] as String,
            NoteCategory.values[row['category'] as int],
            row['body'] as String?,
            NoteColor.values[row['color'] as int],
            _imageConverter.decode(row['image'] as Uint8List?),
            _alarmConverter.decode(row['alarm'] as String?)),
        arguments: [categoryIndex],
        queryableName: 'Note',
        isView: false);
  }

  @override
  Stream<List<Note>> getNotesBySearch(String title) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Note WHERE title LIKE ?1',
        mapper: (Map<String, Object?> row) => Note(
            row['id'] as int?,
            row['title'] as String,
            NoteCategory.values[row['category'] as int],
            row['body'] as String?,
            NoteColor.values[row['color'] as int],
            _imageConverter.decode(row['image'] as Uint8List?),
            _alarmConverter.decode(row['alarm'] as String?)),
        arguments: [title],
        queryableName: 'Note',
        isView: false);
  }

  @override
  Future<void> deleteAllNotes() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Note');
  }

  @override
  Future<void> insertNote(Note note) async {
    await _noteInsertionAdapter.insert(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateNote(Note note) async {
    await _noteUpdateAdapter.update(note, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await _noteDeletionAdapter.delete(note);
  }
}

// ignore_for_file: unused_element
final _imageConverter = ImageConverter();
final _alarmConverter = AlarmConverter();

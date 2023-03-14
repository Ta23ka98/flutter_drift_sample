import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'todos.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //データベースの値を監視する
  Stream<List<Todo>> watchEntries() {
    return (select(todos).watch());
  }

  //データベースの値を取得する
  Future<List<Todo>> get allTodoEntries => select(todos).get();

  //データを追加する
  Future<int> addTodo(String content) async {
    return into(todos).insert(TodosCompanion(content: Value(content)));
  }

  //データを更新する
  Future<int> updateTodo(Todo todo, String content) async {
    return (update(todos)..where((tbl) => tbl.id.equals(todo.id)))
        .write(TodosCompanion(content: Value(content)));
  }

  //データを削除する
  Future<void> deleteTodo(Todo todo) {
    return (delete(todos)..where((tbl) => tbl.id.equals(todo.id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

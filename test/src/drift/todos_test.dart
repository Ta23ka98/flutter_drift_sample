import 'package:flutter_drift_sample/src/drift/todos.dart';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'todos_test.g.dart';

void main() {
  //Flutterの仕様でエラーが出るので、一旦nullableにする
  MyDatabase? database;

  setUp(() {
    database = MyDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    //同上。一旦!をつけてnon-nullableとしておく
    await database!.close();
  });

  test('追加した癰疽の中身がtestになっているかテスト', () async {
    final id = await database!.addTodo('test');
    //すべてのList<Todo>を取得する
    final todo = await database!.allTodoEntries;

    //todoの最初の要素のconntentが"test"であると予想する
    expect(todo.first.content, 'test');
    //todoの最初の要素のconntentが"content"であると予想する(失敗する想定)
    expect(todo.first.content, 'aaaaa');
  });

  test("要素の数が増えているかテスト", () async {
    //追加前のリストを用意
    final before = await database!.allTodoEntries;

    //要素の数が0個であるかテストする
    expect(before.length, 0);

    //リストに要素を1つ追加する
    await database!.addTodo("test");

    //追加後のリストを取得する
    final after = await database!.allTodoEntries;

    //要素の数が増えているかテストする
    expect(after.length, 1);
  });
}

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get content => text()();
}

@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  MyDatabase(QueryExecutor e) : super(e);

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

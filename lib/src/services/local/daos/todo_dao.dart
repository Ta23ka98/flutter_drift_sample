import 'package:drift/drift.dart';
import 'package:flutter_drift_sample/src/services/local/database.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  TodosDao(AppDatabase db) : super(db);

  //データベースの値を取得する
  Future<List<Todo>> getAllTodos() async {
    return select(todos).get();
  }

  //データベースの値を監視する
  Stream<List<Todo>> watchAllTodos() {
    return (select(todos).watch());
  }

  //データを追加する
  Future<int> insertTodo(TodosCompanion todo) async {
    return into(todos).insert(todo);
  }

  //データを更新する
  Future updateTodo(Todo todo) async {
    return update(todos).replace(todo);
  }

  //データを削除する
  Future deleteById(int id) {
    return (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  }
}

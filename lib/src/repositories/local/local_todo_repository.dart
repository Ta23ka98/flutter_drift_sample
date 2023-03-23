import 'package:flutter_drift_sample/src/services/local/daos/todo_dao.dart';
import 'package:flutter_drift_sample/src/services/local/database.dart';

class LocalTodoRepository {
  final TodosDao todosDao;

  LocalTodoRepository(AppDatabase appDatabase)
      : todosDao = appDatabase.todosDao;

  //データベースの値を取得する
  Future<List<Todo>> getAllTodos() async {
    return todosDao.getAllTodos();
  }

  //データベースの値を監視する
  Stream<List<Todo>> watchAllTodos() {
    return todosDao.watchAllTodos();
  }

  //データを追加する
  Future<int> insertTodo(TodosCompanion todo) async {
    return todosDao.insertTodo(todo);
  }

  //データを更新する
  Future updateTodo(Todo todo) async {
    return todosDao.updateTodo(todo);
  }

  //データを削除する
  Future deleteTodoById(int id) {
    return todosDao.deleteById(id);
  }
}

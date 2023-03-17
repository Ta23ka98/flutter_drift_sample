import 'package:flutter_drift_sample/src/services/local/app_database.dart';

import 'local_repository.dart';

class LocalRepositoryProvider {
  final AppDatabase appDatabase;

  late final LocalTodoRepository todoRepo;

  LocalRepositoryProvider(this.appDatabase) {
    todoRepo = LocalTodoRepository(appDatabase);
  }
}

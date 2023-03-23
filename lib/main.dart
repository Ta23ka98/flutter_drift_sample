import 'package:flutter/material.dart';
import 'package:flutter_drift_sample/src/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_drift_sample/src/services/local/app_database.dart';
import 'package:flutter_drift_sample/src/repositories/local/local_repository_provider.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final appDatabase = AppDatabase();
  return appDatabase;
});

final localRepoProvider =
    Provider((ref) => LocalRepositoryProvider(ref.watch(databaseProvider)));

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      //DriftSample(database: database),
    );
  }
}

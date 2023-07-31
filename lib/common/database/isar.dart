import 'package:habito/common/models/routine.isar.dart';
import 'package:habito/common/models/task.isar.dart';
import 'package:habito/common/models/task_recommendation.isar.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  late Future<Isar> _isar;

  IsarDatabase() {
    _isar = _getDb();
  }

  Future<void> saveRecom(String recomm) async {
    final isar = await _isar;
    final newRecomm = Recommendation()..name = recomm;
    final exists =
        await isar.recommendations.filter().nameEqualTo(recomm).findFirst();
    if (exists != null) {
      return;
    }
    isar.writeTxnSync(() => isar.recommendations.putSync(newRecomm));
  }

  Future<List<Recommendation>> getRecommendationsFrom(String value) async {
    final isar = await _isar;
    return isar.recommendations
        .filter()
        .nameStartsWith(value, caseSensitive: false)
        .findAll();
  }

  Future<void> saveTask(Task task) async {
    final isar = await _isar;
    isar.writeTxnSync(() => isar.tasks.putSync(task));
  }

  Future<List<Task>> getTasks() async {
    final isar = await _isar;
    return isar.tasks.where().findAll();
  }

  Future<List<Task>> getTasksByDay(String keyDay) async {
    final isar = await _isar;
    return isar.tasks.where().filter().timeEqualTo(keyDay).findAll();
  }

  Future<void> deleteTask(Id taskId) async {
    final isar = await _isar;
    isar.writeTxn(() => isar.tasks.delete(taskId));
  }
}

extension IsarInitialization on IsarDatabase {
  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    final db = await Isar.open(
      [TaskSchema, RoutineSchema, RecommendationSchema],
      directory: dir.path,
    );
    return db;
  }

  Future<Isar> _getDb() async {
    if (Isar.instanceNames.isEmpty) {
      return await _initIsar();
    } else {
      return Future.value(Isar.getInstance());
    }
  }
}

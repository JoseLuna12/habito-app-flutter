import 'package:habito/common/models/routine.isar.dart';
import 'package:habito/common/models/task.isar.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase {
  late Future<Isar> _isar;

  IsarDatabase() {
    _isar = _getDb();
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
      [TaskSchema, RoutineSchema],
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

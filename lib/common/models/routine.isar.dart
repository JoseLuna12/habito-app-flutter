// import 'package:habito/common/models/tasks.isar.dart';
import 'package:habito/common/models/task.isar.dart';
import 'package:isar/isar.dart';

// id         Int       @id @unique @default(autoincrement())
//   createdAt  DateTime  @default(now())
//   name       String?   @db.VarChar(255)
//   createdBy  User      @relation(fields: [ownerId], references: [id], onDelete: Cascade, onUpdate: Cascade)
//   ownerId    Int
//   tasks      Task[]
//   completed  Boolean   @default(false)
//   time       String?   @unique @db.VarChar(10)
//   isTemplate Boolean   @default(false)
//   Template   Template?
part 'routine.isar.g.dart';

@collection
class Routine {
  Id localId = Isar.autoIncrement;

  String? name;
  bool completed = false;

  @Index()
  String? time;

  bool isTemplate = false;
  final tasks = IsarLinks<Task>();
}

// import 'package:habito/common/models/routines.isar.dart';
import 'package:habito/common/models/routine.isar.dart';
import 'package:isar/isar.dart';

// model Task {
//   id        Int      @id @unique @default(autoincrement())
//   createdAt DateTime @default(now())
//   name      String   @db.VarChar(255)
//   note      String?  @db.VarChar(255)
//   time      String?  @db.VarChar(10)
//   owner     User     @relation(fields: [ownerId], references: [id], onDelete: Cascade, onUpdate: Cascade)
//   ownerId   Int
//   routine   routine? @relation(fields: [routineId], references: [id], onDelete: Cascade, onUpdate: Cascade)
//   routineId Int?

//   @@index([routineId, id, time])
//   @@index([ownerId])
// }
part 'task.isar.g.dart';

@collection
class Task {
  Id localId = Isar.autoIncrement;

  late String name;
  String? note;

  @Index()
  String? time;

  final routine = IsarLink<Routine>();
}

import 'package:habito/common/models/routine.isar.dart';
import 'package:isar/isar.dart';

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

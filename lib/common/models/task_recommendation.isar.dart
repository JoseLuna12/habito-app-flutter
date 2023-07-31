import 'package:isar/isar.dart';

part 'task_recommendation.isar.g.dart';

@collection
class Recommendation {
  Id localId = Isar.autoIncrement;

  @Index()
  late String name;
}

import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String task; 
  @HiveField(2)
  late bool isDone;

  TaskModel(
      {required this.id,
      required this.task,
      this.isDone = false});
}

  part of 'task_cubit.dart';


  sealed class TaskState {}

  final class TaskInitial extends TaskState {}


  class AddTaskState extends TaskState{}


  class DeleteTaskState extends TaskState{}


  class ChangeStateOfTask extends TaskState{}
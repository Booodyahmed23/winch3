import 'package:bloc/bloc.dart';

import '../class_users/task.dart';


part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  List<Task> tasks =[
    Task(title: 'football', finish: false),
    Task(title: 'gym', finish: false),
    Task(title: 'work', finish: false),
    Task(title: 'games', finish: false),
    Task(title: 'quran', finish: false),
  ];

  void deleteTask(int index){
    tasks.removeAt(index);
    emit(DeleteTaskState());

  }
  void addTask(Task newTask){
   tasks.add(newTask);

   emit(AddTaskState());
  }
  void changeStateTask(bool value,int index){
    tasks[index].finish= value;
    emit(ChangeStateOfTask());

  }
}
